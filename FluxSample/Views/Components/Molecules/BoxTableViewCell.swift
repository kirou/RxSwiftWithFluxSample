import UIKit
import SDWebImage

final class BoxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
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
    
    var inputNameLabel: String? = "" {
        didSet {
            nameLabel.text = inputNameLabel
        }
    }
    
    var inputItemCountLabel: Int? {
        didSet {
            
            guard let inputItemCountLabel = inputItemCountLabel else {
                itemCountLabel.isHidden = true
                return
            }
            
            itemCountLabel.text = "フォロワー数: \(String(inputItemCountLabel))"
        }
    }
}
