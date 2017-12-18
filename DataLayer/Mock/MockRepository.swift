import Foundation
import RxSwift
import Library

public final class MockRepository: QiitaRepositoryProtocol {
    public init () {
    }
    
    public func item(parameter: QiitaItemParameter) -> Single<QiitaItemResponse> {
        
        guard let data = MockFile.file(name: "item") else {
            return Single.just(QiitaItemResponse())
        }
        let response = QiitaItemDecoder().decode(data: data) ?? QiitaItemResponse()
        return Single.just(response)
    }
    
    public func itemList(parameter: QiitaItemListParameter) -> Single<[QiitaItemResponse]> {
        
        guard let data = MockFile.file(name: "itemList") else {
            return Single.just([QiitaItemResponse]())
        }
        let response = QiitaItemListDecoder().decode(data: data) ?? [QiitaItemResponse]()
        return Single.just(response)
    }
    
    public func userList(parameter: QiitaUserListParameter) -> Single<[QiitaUserResponse]> {
        
        guard let data = MockFile.file(name: "userList") else {
            return Single.just([QiitaUserResponse]())
        }
        let response = QiitaUserListDecoder().decode(data: data) ?? [QiitaUserResponse]()

        return Single.just(response)
    }
    
    public func userList2(parameter: QiitaUserListParameter) -> Single<[QiitaUserResponse]> {
        
        guard let data = MockFile.file(name: "userList2") else {
            return Single.just([QiitaUserResponse]())
        }
        let response = QiitaUserListDecoder().decode(data: data) ?? [QiitaUserResponse]()
        
        return Single.just(response)
    }
}
