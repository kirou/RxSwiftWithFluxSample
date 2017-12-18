import Foundation
import RxSwift
import RxCocoa

public extension ObservableType {
    public func unwrap<T>() -> Observable<T> where E == T? {
        return self
            .filter { value in
                if case .some = value {
                    return true
                } else {
                    return false
                }
            }.map { $0! }
    }
}

public extension Reactive where Base: UIViewController {
    public var viewWillAppear: Observable<Bool> {
        return sentMessage(#selector(Base.viewWillAppear(_:)))
            .map { $0.first as! Bool }
            .share(replay: 1, scope: .whileConnected)
            .concat(Observable.never())
    }
}
