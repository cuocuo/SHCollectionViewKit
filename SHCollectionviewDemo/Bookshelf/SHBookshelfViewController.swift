//
/**
 * @brief  	<#usage#>
 * @author 	shiheng
 * @date   	2021/4/9
 */

import UIKit

class SHBookshelfViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let maxNum: Int = 4
    private var mockData = [[UIColor]]()
    private var prevIndexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Book Shelf"
        mockData = [[UIColor.white, UIColor.brown, UIColor.red],
                    [UIColor.blue, UIColor.green, UIColor.gray],
                    [UIColor.magenta, UIColor.yellow, UIColor.cyan]]

        let flowLayout = SHCollectionViewDecorationLayout()
        let margin: CGFloat = 20
        let section: CGFloat = 15
        flowLayout.minimumLineSpacing = margin
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: section, left: margin, bottom: section, right: margin)
        flowLayout.scrollDirection = .vertical

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), collectionViewLayout: flowLayout)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        view.addSubview(collectionView)

        // 添加手势
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }

    @objc func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            let postion = gesture.location(in: collectionView)
            guard let selectedIndexPath = collectionView.indexPathForItem(at: postion), let cell = collectionView.cellForItem(at: selectedIndexPath) else {
                break
            }
            prevIndexPath = selectedIndexPath
            UIView.animate(withDuration: 0.2) {
                cell.center = postion
                cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
            // 开始交互
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            // 更新位置
            if let moveIndexPath: IndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) {
                if prevIndexPath != moveIndexPath {
                    // 判断书架是否放满
                    if collectionView.numberOfItems(inSection: moveIndexPath.section) >= maxNum {
                        
                    }
                }
            }
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            // 结束交互
            collectionView.endInteractiveMovement()
        default:
            // 默认取消交互
            collectionView.cancelInteractiveMovement()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = self.view.bounds
    }
}

extension SHBookshelfViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 120)
    }
}

extension SHBookshelfViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension SHBookshelfViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockData[section].count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mockData.count
    }

    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UICollectionViewCell.self), for: indexPath)
        cell.backgroundColor = mockData[indexPath.section][indexPath.row]
        cell.layer.cornerRadius = 6
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let book = mockData[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        mockData[destinationIndexPath.section].insert(book, at: (destinationIndexPath as NSIndexPath).row)
    }
}
