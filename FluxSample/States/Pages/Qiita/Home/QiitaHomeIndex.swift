import Foundation
import DataLayer

protocol QiitaHomeIndexProtocol {
    var action: QiitaHomeActionProtocol { get }
    var store: QiitaStoreProtocol { get }
}

final class QiitaHomeIndex: QiitaHomeIndexProtocol {
    private(set) var action: QiitaHomeActionProtocol
    private(set) var store: QiitaStoreProtocol
    
    init() {
        let dispatcher = QiitaDispatcher.shared
        let repository = MockRepository()
        store = QiitaStore.shared
        action = QiitaHomeActionCreator(repository: repository, dispatcher: dispatcher)
    }
}
