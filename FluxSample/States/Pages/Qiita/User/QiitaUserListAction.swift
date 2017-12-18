import Foundation
import RxSwift
import Library
import DataLayer

protocol QiitaUserListActionProtocol {
    func show(page: Int, perPage: Int)
}

/// ファサードに近いイメージですね。
final class QiitaUserListActionCreator: QiitaUserListActionProtocol {
    
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
        
        let pageState: QiitaUserListState.PageState = page == 1 ? .loading : .paging
        dispatcher.action.dispatch(QiitaUserListActions.SetPageState(pageState: pageState))

        /// Repositoryを経由して望むデータを取得し、Actionに変換してdispatchする
        repository.userList(parameter: QiitaUserListParameter(page: page, perPage: perPage))
            .map { response -> QiitaUserListActions.SetUserListResult in
                
                let userList = QiitaUserTranslator.translate(data: response)
                return QiitaUserListActions.SetUserListResult(
                    page: page,
                    perPage: perPage,
                    userList: userList,
                    pageState: .updated)
            }
            .subscribeOn(Dependencies.shared.backgroundScheduler)
            .subscribe(
                onSuccess: { [weak self] action in
                    self?.dispatcher.action.dispatch(action)
                },
                onError: { [weak self] error in
                    /// ひとまず何かのメッセージ
                    let error = AppError(message: error.localizedDescription)
                    self?.dispatcher.action.dispatch(
                        QiitaUserListActions.SetErrorResult(error: error)
                    )
                }
            ).disposed(by: disposeBag)
    }
}

/// ActionCreatorで生成したいActionたちを記載してく
enum QiitaUserListActions {
    
    struct SetUserListResult: Action {
        var page: Int
        var perPage: Int
        var userList: [QiitaUser] = []
        var pageState: QiitaUserListState.PageState
    }
    
    struct SetPageState: Action {
        var pageState: QiitaUserListState.PageState
    }
    
    struct SetErrorResult: Action {
        var error: AppError
    }
}
