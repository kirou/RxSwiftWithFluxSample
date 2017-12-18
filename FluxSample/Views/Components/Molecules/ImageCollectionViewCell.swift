import Foundation
import UIKit
import SDWebImage

final class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!

    var inputThumbnail: URL? {
        didSet {
            thumbnailImageView.sd_setImage(
                with: inputThumbnail,
                placeholderImage: UIImage(named: "loading"),
                options: [],
                completed: {  [weak self] (_: UIImage?, _, cacheType: SDImageCacheType, _) in
                    if cacheType == .none {
                        self?.ex.fadeIn(duration: .normal)
                    }
                }
            )
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
