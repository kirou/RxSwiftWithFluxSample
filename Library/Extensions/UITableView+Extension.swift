import Foundation
import UIKit

public extension Extension where Base: UITableView {
    
    public func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        
        let className = String(describing: cellType)
        let nib = UINib(nibName: className, bundle: bundle)
        base.register(nib, forCellReuseIdentifier: className)
    }
    
    public func register<T: UITableViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        
        let className = String(describing: type)
        return base.dequeueReusableCell(withIdentifier: className, for: indexPath) as! T
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type) -> T {
        
        let className = String(describing: type)
        return base.dequeueReusableCell(withIdentifier: className) as! T
    }
    
    public func register<T: UITableViewHeaderFooterView>(headerFooterType: T.Type, bundle: Bundle? = nil) {
        
        let className = String(describing: headerFooterType)
        let nib = UINib(nibName: className, bundle: bundle)
        base.register(nib, forHeaderFooterViewReuseIdentifier: className)
    }
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        
        let className = String(describing: type)
        return base.dequeueReusableHeaderFooterView(withIdentifier: className) as! T
    }
}
