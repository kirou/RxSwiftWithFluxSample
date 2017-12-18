import UIKit

extension UIViewController: ExtensionCompatible {}

public extension Extension where Base: UIViewController {
    
    public static func instantiate() -> Base {
        return instantiate(storyboardName: Base.ex.className())
    }
    
    public static func instantiateInitialViewController() -> Base {
        let pageViewController = UIStoryboard(name: Base.ex.className(), bundle: Bundle(for: Base.self))
        return pageViewController.instantiateInitialViewController() as! Base
    }

    public static func instantiate(storyboardName: String, bundle: Bundle? = nil) -> Base {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardName) as! Base
    }
    
    public static func instantiate(storyboardName: String, storyboardId: String, bundle: Bundle? = nil) -> Base {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardId) as! Base
    }
    
    public var suitableInsets: UIEdgeInsets {
        
        if #available(iOS 11.0, *) {
            let insets = base.view.safeAreaInsets
            return insets
        } else {
            return UIEdgeInsets(top: base.topLayoutGuide.length,
                                left: 0.0,
                                bottom: base.bottomLayoutGuide.length,
                                right: 0.0)
        }
    }
}
