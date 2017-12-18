import Foundation
import RxSwift
import Library
import DataLayer

protocol QiitaItemListActionProtocol {
    func show(page: Int, perPage: Int)
}

/// ファサードに近いイメージですね。
final class QiitaItemListActionCreator: QiitaItemListActionProtocol {
    
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
        
        let pageState: QiitaItemListState.PageState = page == 1 ? .loading : .paging
        dispatcher.action.dispatch(QiitaItemListActions.SetPageState(pageState: pageState))

        /// Repositoryを経由して望むデータを取得し、Actionに変換してdispatchする
        repository.itemList(parameter: QiitaItemListParameter(page: page, perPage: perPage))
            .map { response -> QiitaItemListActions.SetItemListResult in
                let itemList = QiitaItemTranslator.translate(data: response)
                return QiitaItemListActions.SetItemListResult(
                    page: page,
                    perPage: perPage,
                    itemList: itemList,
                    pageState: .updated
                )
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
                        QiitaItemListActions.SetErrorResult(error: error)
                    )
                }
            ).disposed(by: disposeBag)
    }
}

/// ActionCreatorで生成したいActionたちを記載してく
enum QiitaItemListActions {
    
    struct SetItemListResult: Action {
        var page: Int
        var perPage: Int
        var itemList: [QiitaItem] = []
        var pageState: QiitaItemListState.PageState
    }
    
    struct SetPageState: Action {
        var pageState: QiitaItemListState.PageState
    }
    
    struct SetErrorResult: Action {
        var error: AppError
    }
}
