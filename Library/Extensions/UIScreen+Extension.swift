import Foundation
import UIKit

extension UIScreen: ExtensionCompatible {}

public extension Extension where Base == UIScreen {
    
    public static var bounds: CGRect {
        return UIScreen.main.bounds
    }
    
    public static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public static var isLandscape: Bool {
        return UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)
    }
    
    public static var isPortrait: Bool {
        return UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation)
    }
}
