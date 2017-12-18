import Foundation
import UIKit

extension UIDevice: ExtensionCompatible {}

public extension Extension where Base == UIDevice {
    
    public static var device: UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
    
    public static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
