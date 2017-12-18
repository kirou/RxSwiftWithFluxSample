import Foundation
import UIKit
import Library

final class ItemTableView: UITableView {
    
    var didSelect: ((QiitaItem) -> Void)?
    var data: [QiitaItem]? {
        didSet {
            guard let data = data, data.count > 0 else { return }
            reloadData()
            isHidden = false
        }
    }
    
    fileprivate let useCell = LabelTableViewCell.self
    private let cellHeight: CGFloat = 90
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadNib()
    }
    
    override var intrinsicContentSize: CGSize {
        
        guard let count: Int = data?.count, count > 0 else { return .zero }
        
        var size: CGSize = bounds.size
        size.height = CGFloat(count) * cellHeight
        return size
    }

    private func loadNib() {
        
        isHidden = true
        delegate = self
        dataSource = self
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = 90.0
        
        let bundle = Bundle(for: type(of: self))
        ex.register(cellType: useCell, bundle: bundle)
    }
}

extension ItemTableView: UITableViewDataSource, UITableViewDelegate {
    
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
