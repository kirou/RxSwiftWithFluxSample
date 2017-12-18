import UIKit
import RxSwift
import Library

class ItemListViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: ItemTableView!
    
    var navigationTitle: String = "一覧"

    private var index: QiitaItemListIndexProtocol!
    private let disposeBag: DisposeBag = DisposeBag()
    private let viewRefreshControl: UIRefreshControl = UIRefreshControl()
    private var isRefreshingManually = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navigationTitle
        
        tableView.isHidden = true
        tableView.refreshControl = viewRefreshControl
        tableView.tableFooterView = UIView(frame: .zero)
        
        activityIndicatorView.startAnimating()
        
        index = QiitaItemListIndex()
        observeStore()
        observeUI()
        
        index.action.show(page: 1, perPage: 10)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if #available(iOS 11, *) {
            /// iOS11は自動で調節してくれる
        } else {
            /// iOS10では余白が必要
            let insets = ex.suitableInsets
            tableView.contentInset = insets
            tableView.scrollIndicatorInsets = insets
        }
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    deinit {
    }
    
    private func observeStore() {
        
        index.store.itemList
            .asDriver()
            .skip(1)
            .filter { $0.0?.pageState == .updated }
            .drive(
                onNext: { [weak self] data, error in
                    guard let data = data, error == nil else { return }
                    self?.updateView(data: data)
                }
            ).disposed(by: disposeBag)
    }
    
    private func observeUI() {
        
        viewRefreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                self?.index.action.show(page: 1, perPage: 10)
                self?.viewRefreshControl.endRefreshing()
            }).disposed(by: disposeBag)
    }
    
    private func updateView(data: QiitaItemListState) {
        
        tableView.data = data.itemList
        tableView.didSelect = { [weak self] item in
        }
        
        defer {
            if activityIndicatorView.isAnimating {
                activityIndicatorView.stopAnimating()
                activityIndicatorView.isHidden = true
            }
        }
    }
}

extension ItemListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isRefreshingManually = scrollView.rx.pullToRefreshing( isRefreshingManually )
    }
}
