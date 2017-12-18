import Foundation
import UIKit

final class MainNavigationViewController: UINavigationController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        if isViewLoaded && view.window == nil {
            view = nil
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
