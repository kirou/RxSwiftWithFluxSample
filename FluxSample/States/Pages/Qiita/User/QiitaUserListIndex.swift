import Foundation
import DataLayer

protocol QiitaUserListIndexProtocol {
    var action: QiitaUserListActionProtocol { get }
    var store: QiitaStoreProtocol { get }
}

final class QiitaUserListIndex: QiitaUserListIndexProtocol {
    private(set) var action: QiitaUserListActionProtocol
    private(set) var store: QiitaStoreProtocol
    
    init() {
        let dispatcher = QiitaDispatcher.shared
        let repository = MockRepository()
        store = QiitaStore.shared
        action = QiitaUserListActionCreator(repository: repository, dispatcher: dispatcher)
    }
}
