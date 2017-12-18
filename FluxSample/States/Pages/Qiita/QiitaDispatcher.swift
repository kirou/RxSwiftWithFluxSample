import Foundation
import RxSwift

final class QiitaDispatcher {
    
    static let shared = QiitaDispatcher()
    let action = DispatchSubject<Action>()
}
