//
/**
 * @brief  	书架装饰
 * @author 	shiheng
 * @date   	2021/4/9
 */
	

import UIKit

class BookshelfDecorationView: UICollectionReusableView {
    fileprivate var bg_imageView = UIImageView()
     
        override init(frame: CGRect) {
            super.init(frame: frame)
            bg_imageView.frame = bounds
            self.bg_imageView.image = UIImage(named: "bookshelf")?.resizableImage(withCapInsets: .zero, resizingMode: .tile)
            self.addSubview(bg_imageView)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            bg_imageView.frame = bounds
        }
        
        override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
            super.apply(layoutAttributes)
           
        }
}
