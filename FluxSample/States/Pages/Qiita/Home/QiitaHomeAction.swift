import Foundation
import RxSwift
import Library
import DataLayer

protocol QiitaHomeActionProtocol {
    func show(page: Int, perPage: Int)
}

/// ファサードに近いイメージですね。
final class QiitaHomeActionCreator: QiitaHomeActionProtocol {
    
    fileprivate let repository: QiitaRepositoryProtocol
    fileprivate let dispatcher: QiitaDispatcher
    fileprivate let disposeBag: DisposeBag = DisposeBag()
    
    init(repository: QiitaRepositoryProtocol, dispatcher: QiitaDispatcher) {
        
        self.repository = repository
        self.dispatcher = dispatcher
    }
    
    deinit {
        print(String(describing: type(of: self)))
    }
    
    func show(page: Int, perPage: Int) {
        
        /// Repositoryを経由して望むデータを取得し、Actionに変換してdispatchする
        Single.zip(
            repository.itemList(parameter: QiitaItemListParameter(page: page, perPage: perPage)),
            repository.userList(parameter: QiitaUserListParameter(page: page, perPage: perPage))
        ) { items, users in
            return (items, users)
            }
            .map { response -> QiitaHomeActions.SetHomeResult in
                let itemList = QiitaItemTranslator.translate(data: response.0)
                let userList = QiitaUserTranslator.translate(data: response.1)
                return QiitaHomeActions.SetHomeResult(itemList: itemList, userList: userList)
            }
            .subscribeOn(Dependencies.shared.backgroundScheduler)
            .subscribe(
                onSuccess: { [weak self] action in
                    self?.dispatcher.action.dispatch(action)
                },
                onError: { [weak self] error in
                    let error = AppError(message: error.localizedDescription)
                    self?.dispatcher.action.dispatch(
                        QiitaHomeActions.SetErrorResult(error: error)
                    )
                }
            ).disposed(by: disposeBag)
    }
}

/// ActionCreatorで生成したいActionたちを記載してく
enum QiitaHomeActions {
    
    struct SetHomeResult: Action {
        var itemList: [QiitaItem] = []
        var userList: [QiitaUser] = []
    }
    
    struct SetErrorResult: Action {
        var error: AppError
    }
}
