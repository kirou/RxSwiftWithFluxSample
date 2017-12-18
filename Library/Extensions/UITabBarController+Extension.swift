import Foundation
import UIKit

public extension Extension where Base: UITabBarController {
    
    public func hideTabBar(hidden: Bool, duration: TimeInterval = 0.2) {
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        
        let views: [UIView] = base.view.subviews as [UIView]
        
        for view: UIView in views {
            
            let y = UIScreen.ex.height - base.tabBar.bounds.height
            if view.isKind(of: UITabBar.self) {
                view.frame.origin.y = hidden ? UIScreen.ex.height : y
            } else {
                view.frame.size.height = hidden ? UIScreen.ex.height : y
            }
        }
        UIView.commitAnimations()
    }

    /// タイトルからタブの位置を取得する
    ///
    /// - Parameter title: タイトル
    /// - Returns: 位置（なければnil）
    public func index(of title: String) -> Int? {
        return base.tabBar.items?.map({ $0.title ?? "" }).index(of: title)
    }
}
