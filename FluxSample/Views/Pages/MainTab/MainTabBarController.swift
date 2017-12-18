import UIKit
import Library

final class MainTabBarController: UITabBarController {
    
    enum TabItem {
        case qiita

        var name: String {
            switch self {
            case .qiita:
                return "Qiita"
            }
        }
        
        var offImage: String {
            switch self {
            case .qiita:
                return "home"
            }
        }
        
        var onImage: String {
            switch self {
            case .qiita:
                return "home_current"
            }
        }
    }
    
    private var tabBarItemViews: [UIView] {
        return tabBar.subviews
            .filter { $0.isUserInteractionEnabled }
            .sorted { $0.frame.minX < $1.frame.minX }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    private func setting() {
        
        UITabBar.appearance().tintColor = Colors.Icon.focus.color
        
        let tabs: [(vc: UIViewController, title: String, imageName: String, selectedImageName: String)] = [
            (HomeViewController.ex.instantiate(), TabItem.qiita.name, TabItem.qiita.offImage, TabItem.qiita.onImage)
        ]
        
        viewControllers = tabs.map { tab in
            let nc: MainNavigationViewController = MainNavigationViewController.ex.instantiate()
            nc.viewControllers = [tab.vc]
            nc.tabBarItem.title = tab.title
            nc.tabBarItem.image = UIImage(named: tab.imageName)?.withRenderingMode(.alwaysOriginal)
            nc.tabBarItem.selectedImage = UIImage(named: tab.selectedImageName)?.withRenderingMode(.alwaysOriginal)
            nc.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 1.0, vertical: -2.0)
            return nc
        }
    }
}
