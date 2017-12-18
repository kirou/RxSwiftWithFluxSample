import Foundation
import RxSwift
import RxCocoa
import Library

/// 状態を保持するところ。
/// ページ単位ではなく、もっと大きい単位(機能)の状態を保つ

protocol QiitaStoreProtocol {
    var home: BehaviorRelay<(QiitaHomeState?, AppError?)> { get }
    var itemList: BehaviorRelay<(QiitaItemListState?, AppError?)> { get }
    var userList: BehaviorRelay<(QiitaUserListState?, AppError?)> { get }
}

final class QiitaStore: QiitaStoreProtocol {
    
    static var shared = QiitaStore()

    /// 本来はRxPropertyを使うとか、protocolで公開するのはObservableにするとかあるとは思いますが
    /// プロパティ増えるし、fluxの意図を把握してもらえればそこまでしなくてもいいのかもしれないです
    private(set) var home = BehaviorRelay<(QiitaHomeState?, AppError?)>(value: (nil, nil))
    private(set) var itemList = BehaviorRelay<(QiitaItemListState?, AppError?)>(value: (nil, nil))
    private(set) var userList = BehaviorRelay<(QiitaUserListState?, AppError?)>(value: (nil, nil))

    private let disposeBag = DisposeBag()

    init(dispatcher: QiitaDispatcher = .shared) {
        
        dispatcher.action
            .subscribe(
                onNext: { [weak self] action in
                    self?.reducer(action: action, state: .shared)
                }
            ).disposed(by: disposeBag)
    }

    deinit {
    }
}

private extension QiitaStore {
    
    /// Actionと今のStateから新しいStateをStoreに持たせておく
    func reducer(action: Action, state: QiitaStore) {
        switch action {
        /// home
        case let action as QiitaHomeActions.SetHomeResult:
            let homeState = QiitaHomeState(itemList: action.itemList, userList: action.userList)
            state.home.accept((homeState, nil))
        case let action as QiitaHomeActions.SetErrorResult:
            state.home.accept((nil, action.error))
        /// item list
        case let action as QiitaItemListActions.SetItemListResult:
            
            /// 追加読み込み
            var addItems: [QiitaItem]
            if action.pageState == .paging, var list = state.itemList.value.0?.itemList, action.itemList.count > 0 {
                list.append(contentsOf: action.itemList)
                addItems = list
            /// 初回
            } else {
                addItems = action.itemList
            }
            
            let list = QiitaItemListState(
                itemList: addItems,
                page: action.page,
                perPage: action.perPage,
                pageState: action.pageState
            )
            state.itemList.accept((list, nil))
            
        case let action as QiitaItemListActions.SetPageState:
            
            guard let stateItem = state.itemList.value.0 else { return }
            let list = QiitaItemListState(
                itemList: stateItem.itemList,
                page: stateItem.page,
                perPage: stateItem.perPage,
                pageState: action.pageState
            )
            state.itemList.accept((list, nil))

        case let action as QiitaItemListActions.SetErrorResult:
            state.itemList.accept((nil, action.error))
        /// user list
        case let action as QiitaUserListActions.SetUserListResult:
            
            /// 追加読み込み
            var addUser: [QiitaUser]
            if action.pageState == .paging, var list = state.userList.value.0?.userList, action.userList.count > 0 {
                list.append(contentsOf: action.userList)
                addUser = list
                /// 初回
            } else {
                addUser = action.userList
            }
            
            let list = QiitaUserListState(
                userList: addUser,
                page: action.page,
                perPage: action.perPage,
                pageState: action.pageState
            )
            state.userList.accept((list, nil))
        case let action as QiitaUserListActions.SetPageState:
            
            guard let stateUser = state.userList.value.0 else { return }
            let list = QiitaUserListState(
                userList: stateUser.userList,
                page: stateUser.page,
                perPage: stateUser.perPage,
                pageState: action.pageState
            )
            state.userList.accept((list, nil))
        case let action as QiitaUserListActions.SetErrorResult:
            state.userList.accept((nil, action.error))
        default:
            break
        }
    }
}
