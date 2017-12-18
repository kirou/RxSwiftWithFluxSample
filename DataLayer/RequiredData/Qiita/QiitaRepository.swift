import Foundation
import RxSwift
import Library

public protocol QiitaRepositoryProtocol {
    
    func item(parameter: QiitaItemParameter) -> Single<QiitaItemResponse>
    func itemList(parameter: QiitaItemListParameter) -> Single<[QiitaItemResponse]>
    func userList(parameter: QiitaUserListParameter) -> Single<[QiitaUserResponse]>
    func userList2(parameter: QiitaUserListParameter) -> Single<[QiitaUserResponse]>
}

public extension QiitaRepositoryProtocol {
}

public final class QiitaRepository: QiitaRepositoryProtocol {

    private let dataStore: QiitaDataStore
    private let retryCount: Int = 3
    
    public init () {
        dataStore = QiitaDataStore()
    }
    
    public func item(parameter: QiitaItemParameter) -> Single<QiitaItemResponse> {
        
        return dataStore.item(parameter: parameter)
            .retry(retryCount)
            .map { data in
                guard let data = data else {
                    throw Errors.emptyData
                }
                return data
        }
    }
    
    public func itemList(parameter: QiitaItemListParameter) -> Single<[QiitaItemResponse]> {

        return dataStore.itemList(parameter: parameter)
            .retry(retryCount)
            .map { data in
                guard let data = data else {
                    throw Errors.emptyData
                }
                return data
            }
    }
    
    public func userList(parameter: QiitaUserListParameter) -> Single<[QiitaUserResponse]> {
        
        return dataStore.userList(parameter: parameter)
            .retry(retryCount)
            .map { data in
                guard let data = data else {
                    throw Errors.emptyData
                }
                return data
        }
    }
    
    public func userList2(parameter: QiitaUserListParameter) -> Single<[QiitaUserResponse]> {
        
        return dataStore.userList(parameter: parameter)
            .retry(retryCount)
            .map { data in
                guard let data = data else {
                    throw Errors.emptyData
                }
                return data
        }
    }
}
