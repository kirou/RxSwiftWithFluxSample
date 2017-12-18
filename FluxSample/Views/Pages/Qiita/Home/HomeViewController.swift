import UIKit
import RxSwift
import Library

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    /// components
    @IBOutlet weak var itemListView: ItemListView!
    @IBOutlet weak var userListView: UserListView!
    
    /// 高さの制約
    @IBOutlet weak var itemListViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var userListViewConstraint: NSLayoutConstraint!
    
    fileprivate var index: QiitaHomeIndexProtocol?
    fileprivate let disposeBag: DisposeBag = DisposeBag()
    
    fileprivate let viewRefreshControl: UIRefreshControl = UIRefreshControl()
    fileprivate var isRefreshingManually = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.startAnimating()
        stackView.isHidden = true
        scrollView.delegate = self
        scrollView.refreshControl = viewRefreshControl
        
        index = QiitaHomeIndex()
        
        observeStore()
        observeUI()
        index?.action.show(page: 1, perPage: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if #available(iOS 11, *) {
            /// iOS11は自動で調節してくれる
        } else {
            /// iOS10では余白が必要
            let insets = ex.suitableInsets
            scrollView.contentInset = insets
            scrollView.scrollIndicatorInsets = insets
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.ex.hideTabBar(hidden: false)
    }
    
    private func observeUI() {
        viewRefreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                guard let index = self?.index else { return }
                index.action.show(page: 1, perPage: 1)
                self?.viewRefreshControl.endRefreshing()
            }).disposed(by: disposeBag)
    }
    
    private func observeStore() {
        
        index?.store.home
            .asDriver()
            .skip(1)
            .drive(
                onNext: { [weak self] data, error in
                    guard let data = data, error == nil else { return }
                    self?.updateView(data: data)
                }
            ).disposed(by: disposeBag)
    }
    
    deinit {
    }
    
    private func updateView(data: QiitaHomeState) {
        
        itemListView(data: data)
        userListView(data: data)

        defer {
            updateViewHeight()
            
            stackView.isHidden = false
            
            if activityIndicatorView.isAnimating {
                activityIndicatorView.stopAnimating()
                activityIndicatorView.isHidden = true
            }
        }
    }
    
    private func itemListView(data: QiitaHomeState) {
        
        guard data.itemList.count > 0 else {
            itemListView.isHidden = true
            return
        }
        
        itemListView.inputNameLabel = "投稿一覧"
        itemListView.data = data.itemList
        itemListView.didTapAllView = { [weak self] in
            let vc = ItemListViewController.ex.instantiate()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func userListView(data: QiitaHomeState) {
        
        guard data.userList.count > 0 else {
            userListView.isHidden = true
            return
        }
        
        userListView.data = data.userList
        userListView.inputNameLabel = "ユーザ"
        userListView.didTapAllView = { [weak self] in
            let vc = UserListViewController.ex.instantiate()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func updateViewHeight() {
        
        itemListViewConstraint.constant = itemListView.intrinsicContentSize.height
        userListViewConstraint.constant = userListView.intrinsicContentSize.height
        
        view.layoutIfNeeded()
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isRefreshingManually = scrollView.rx.pullToRefreshing( isRefreshingManually )
    }
}
