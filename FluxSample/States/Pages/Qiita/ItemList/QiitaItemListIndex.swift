import Foundation
import DataLayer

protocol QiitaItemListIndexProtocol {
    var action: QiitaItemListActionProtocol { get }
    var store: QiitaStoreProtocol { get }
}

final class QiitaItemListIndex: QiitaItemListIndexProtocol {
    private(set) var action: QiitaItemListActionProtocol
    private(set) var store: QiitaStoreProtocol
    
    init() {
        let dispatcher = QiitaDispatcher.shared
        let repository = MockRepository()
        store = QiitaStore.shared
        action = QiitaItemListActionCreator(repository: repository, dispatcher: dispatcher)
    }
}
