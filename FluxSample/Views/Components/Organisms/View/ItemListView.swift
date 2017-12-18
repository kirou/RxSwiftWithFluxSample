import Foundation
import UIKit
import Library

@IBDesignable final class ItemListView: UIView {
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var didTapButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    @IBAction func didTapButtonAction() {
        
        didTapAllView?()
    }
    
    var inputNameLabel: String? {
        didSet {
            nameLabel.text = inputNameLabel
            nameLabel.sizeToFit()
        }
    }
    
    var data: [QiitaItem]? {
        didSet {
            guard let data = data, data.count > 0 else { return }
            
            invalidateIntrinsicContentSize()
            tableView.reloadData()
            tableView.isHidden = false
        }
    }
    
    /// 一覧ボタンを表示するか
    var isDisplayDidTapButton: Bool = true {
        didSet {
            didTapButton.isHidden = !isDisplayDidTapButton
        }
    }
    
    var didSelect: ((QiitaItem) -> Void)?
    var didTapAllView: (() -> Void)?

    fileprivate let cellHeight: CGFloat = 90
    fileprivate var cellSizeInfo: (laneCount: CGFloat, size: CGSize)?
    fileprivate let useCell = LabelTableViewCell.self

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadNib()
    }
    
    override var intrinsicContentSize: CGSize {
        
        guard let count: Int = data?.count, count > 0 else { return .zero }

        nameView.layoutIfNeeded()
        
        var size: CGSize = bounds.size
        let height: CGFloat = CGFloat(count) * cellHeight + nameView.bounds.size.height

        size.height = height
            
        return size
    }
    
    private func loadNib() {
        
        let bundle = Bundle(for: type(of: self))
        let view = ItemListView.ex.instantiateUiView(
            withOwner: self,
            bundle: bundle
        )
        
        addSubview(view)
        ex.addConstraints(for: view)
        tableView.ex.register(cellType: useCell, bundle: bundle)
        
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ItemListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.ex.dequeueReusableCell(with: useCell, for: indexPath)
        guard let item = data?[indexPath.item] else { return cell }
        
        cell.inputNameLabel = item.title
        cell.inputLikeCountLabel = item.likeCount
        cell.inputUserNameLabel = item.user?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = data?[indexPath.row] else { return }
        didSelect?(model)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
