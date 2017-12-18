import Foundation
import UIKit
import Library

final class UserTableView: UITableView {
    
    var didSelect: ((QiitaUser) -> Void)?
    var data: [QiitaUser]? {
        didSet {
            guard let data = data, data.count > 0 else { return }
            reloadData()
            isHidden = false
        }
    }
    
    fileprivate let useCell = BoxTableViewCell.self
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadNib()
    }
    
    private func loadNib() {
        
        isHidden = true
        delegate = self
        dataSource = self
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = 120.0
        
        let bundle = Bundle(for: type(of: self))
        ex.register(cellType: useCell, bundle: bundle)
    }
}

extension UserTableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.ex.dequeueReusableCell(with: useCell, for: indexPath)
        guard let item = data?[indexPath.item] else { return cell }
        
        cell.inputNameLabel = item.name
        cell.inputThumbnail = item.profileImageUrl
        cell.inputItemCountLabel = item.followersCount
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = data?[indexPath.row] else { return }
        didSelect?(model)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
