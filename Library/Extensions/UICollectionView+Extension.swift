import Foundation
import UIKit

public extension Extension where Base: UICollectionView {
    
    public func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let identifier: String = String(describing: cellType)
        let nib = UINib(nibName: identifier, bundle: bundle)
        base.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    public func register<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }
    
    public func register<T: UICollectionReusableView>(reusableViewType: T.Type, of kind: String = UICollectionElementKindSectionHeader) {
        let className = reusableViewType.ex.className()
        let nib = UINib(nibName: className, bundle: nil)
        base.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    public func register<T: UICollectionReusableView>(reusableViewTypes: [T.Type], kind: String = UICollectionElementKindSectionHeader) {
        reusableViewTypes.forEach { register(reusableViewType: $0, of: kind) }
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T? {
        return base.dequeueReusableCell(withReuseIdentifier: type.ex.className(), for: indexPath) as? T
    }
    
    public func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type, for indexPath: IndexPath, of kind: String = UICollectionElementKindSectionHeader) -> T? {
        return base.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.ex.className(), for: indexPath) as? T
    }
}
