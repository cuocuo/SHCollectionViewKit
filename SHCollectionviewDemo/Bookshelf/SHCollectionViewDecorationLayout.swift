//
/**
 * @brief  	书架
 * @author 	shiheng
 * @date   	2021/4/9
 */

import UIKit

class SHCollectionViewDecorationLayout: UICollectionViewFlowLayout {
    private var sectionAttrs = [UICollectionViewLayoutAttributes]()

    override init() {
        super.init()
        register(BookshelfDecorationView.self, forDecorationViewOfKind: NSStringFromClass(BookshelfDecorationView.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()
        
        guard let numberOfSections = collectionView?.numberOfSections,
              let layoutDelegate = collectionView?.delegate as? UICollectionViewDelegateFlowLayout else {
            return
        }

        // 先清除样式
        sectionAttrs.removeAll()

        // 2.计算每个section的装饰视图的布局属性
        for section in 0 ..< numberOfSections {
            // 2.1 获取这个 section 第一个以及最后一个 item 的布局属性
            guard let numberOfItems = collectionView?.numberOfItems(inSection: section),
                  numberOfItems > 0,
                  let firstItem = layoutAttributesForItem(at: IndexPath(item: 0, section: section)),
                  let lastItem = layoutAttributesForItem(at: IndexPath(item: numberOfItems - 1, section: section)) else {
                continue
            }

            // 2.2 获取 section 的内边距
            var sectionInset = self.sectionInset
            if let inset = layoutDelegate.collectionView?(collectionView!, layout: self, insetForSectionAt: section) {
                sectionInset = inset
            }

            // 2.3 计算得到该section实际的位置
            var sectionFrame = firstItem.frame.union(lastItem.frame)
            sectionFrame.origin.x = 0
            sectionFrame.origin.y -= sectionInset.top

            // 2.4 计算得到该section实际的尺寸
            if scrollDirection == .horizontal {
                sectionFrame.size.width += sectionInset.left + sectionInset.right
                sectionFrame.size.height = collectionView!.frame.height
            } else {
                sectionFrame.size.width = collectionView!.frame.width
                sectionFrame.size.height += sectionInset.top + sectionInset.bottom
            }

            // 2.5 计算装饰图属性
            var decorationAtt: UICollectionViewLayoutAttributes!
            if let decorations = layoutAttributesForDecorationView(ofKind: NSStringFromClass(BookshelfDecorationView.self), at: IndexPath(item: 0, section: section)) {
                decorationAtt = decorations
            } else {
                decorationAtt = UICollectionViewLayoutAttributes(forDecorationViewOfKind: NSStringFromClass(BookshelfDecorationView.self), with: IndexPath(item: 0, section: section))
            }
            decorationAtt.frame = sectionFrame
            decorationAtt.zIndex = -1

            sectionAttrs.append(decorationAtt)
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = super.layoutAttributesForElements(in: rect)

        attrs!.append(contentsOf: sectionAttrs.filter {
            if $0.representedElementCategory == .decorationView {
                print("测试--> \($0.frame.height)")
            }
            return rect.intersects($0.frame)
        })

        return attrs
    }

    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)

        if elementKind == NSStringFromClass(BookshelfDecorationView.self) {
            let section = indexPath.section
            attributes?.frame = sectionAttrs[section].frame
        }
        return attributes
    }

    override func layoutAttributesForInteractivelyMovingItem(at indexPath: IndexPath, withTargetPosition position: CGPoint) -> UICollectionViewLayoutAttributes {
        let temp = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        temp.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        temp.size = CGSize(width: 80, height: 120)
        temp.center = position
        return temp
    }
}
