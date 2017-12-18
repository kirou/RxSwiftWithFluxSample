import Foundation
import RxSwift

final class DispatchSubject<Element>: ObservableType, ObserverType {
    
    typealias E = Element
    fileprivate let subject = PublishSubject<Element>()
    
    init() {}
    
    func dispatch(_ value: Element) {
        on(.next(value))
    }
    
    func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return subject.subscribe(observer)
    }
    
    func on(_ event: Event<E>) {
        subject.on(event)
    }
}
