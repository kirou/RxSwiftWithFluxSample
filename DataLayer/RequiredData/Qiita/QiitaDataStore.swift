import Foundation
import RxSwift

final class QiitaDataStore {
    
    init() {}
    
    func item(parameter: QiitaItemParameter) -> Single<QiitaItemResponse?> {
        
        let request = QiitaRequest.item(inputParameter: parameter)
        let decode = QiitaItemDecoder()
        return ApiClient.execute(request: request, decode: decode)
    }

    func itemList(parameter: QiitaItemListParameter) -> Single<[QiitaItemResponse]?> {
        
        let request = QiitaRequest.itemList(inputParameter: parameter)
        let decode = QiitaItemListDecoder()
        return ApiClient.execute(request: request, decode: decode)
    }

    func user(parameter: QiitaUserParameter) -> Single<QiitaUserResponse?> {
        
        let request = QiitaRequest.user(inputParameter: parameter)
        let decode = QiitaUserDecoder()
        return ApiClient.execute(request: request, decode: decode)
    }
    
    func userList(parameter: QiitaUserListParameter) -> Single<[QiitaUserResponse]?> {
        
        let request = QiitaRequest.userList(inputParameter: parameter)
        let decode = QiitaUserListDecoder()
        return ApiClient.execute(request: request, decode: decode)
    }
}
