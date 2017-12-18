import UIKit

final class LabelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    var inputNameLabel: String? = "" {
        didSet {
            nameLabel.text = inputNameLabel
        }
    }
    
    var inputLikeCountLabel: Int? {
        didSet {
            guard let inputLikeCountLabel = inputLikeCountLabel else {
                itemCountLabel.isHidden = true
                return
            }
            itemCountLabel.text = "いいね: \(String(inputLikeCountLabel))"
        }
    }
    
    var inputUserNameLabel: String? {
        didSet {
            guard let inputUserNameLabel = inputUserNameLabel else {
                userNameLabel.isHidden = true
                return
            }
            userNameLabel.text = inputUserNameLabel
        }
    }
}
