import Foundation
import UIKit

struct Colors {
    
    enum Label {
        case focus

        var color: UIColor {
            switch self {
            case .focus:
                return #colorLiteral(red: 0.9725490196, green: 0.2823529412, blue: 0.368627451, alpha: 1)
            }
        }
    }
    
    enum Icon {
        case focus
        case defaults
        case disable
        
        var color: UIColor {
            switch self {
            case .focus:
                return #colorLiteral(red: 0.9725490196, green: 0.2823529412, blue: 0.368627451, alpha: 1)
            case .defaults:
                return #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
            case .disable:
                return #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            }
        }
    }
}
