import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
    
    public var contentSize: Observable<CGSize> {
        return observe(CGSize.self, "contentSize").unwrap()
    }
    
    /// 一番下までスクロールした
    public var didEndScroll: ControlEvent<Void> {
        let source: Observable<Void> = contentOffset
            .filter { (contentOffset) in
                contentOffset.y == ceil(self.base.contentSize.height - self.base.bounds.height + self.base.contentInset.bottom)
            }
            .map { (_) in }
            .share(replay: 1)
        return ControlEvent(events: source)
    }
    
    public func pullToRefreshing(_ isRefreshingManually: Bool) -> Bool {
        var ret = isRefreshingManually
        guard let refreshControl = self.base.refreshControl else { return ret }
        if self.base.contentOffset.y < -100.0 {
            if !isRefreshingManually && !refreshControl.isRefreshing {
                ret = true
                self.base.refreshControl?.beginRefreshing()
                self.base.refreshControl?.sendActions(for: .valueChanged)
            }
        } else if base.contentOffset.y >= 0 || !self.base.isDragging {
            ret = false
        }
        return ret
    }
}
