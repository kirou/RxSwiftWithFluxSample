import Foundation
import UIKit

extension UIView: ExtensionCompatible {}

public extension UIView {
    var isVisible: Bool {
        get { return !isHidden }
        set { isHidden = !newValue }
    }
}

public extension Extension where Base: UIView {
    
    public func addConstraints(for childView: UIView, insets: UIEdgeInsets = .zero) {
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        base.topAnchor.constraint(equalTo: childView.topAnchor, constant: insets.top).isActive = true
        base.bottomAnchor.constraint(equalTo: childView.bottomAnchor, constant: insets.bottom).isActive = true
        base.leadingAnchor.constraint(equalTo: childView.leadingAnchor, constant: insets.left).isActive = true
        base.trailingAnchor.constraint(equalTo: childView.trailingAnchor, constant: insets.right).isActive = true
    }
    
    public static func instantiate(withOwner ownerOrNil: Any? = nil) -> Base {
        
        let nib = UINib.init(nibName: Base.ex.className(), bundle: nil)
        return nib.instantiate(withOwner: ownerOrNil, options: nil).first as! Base
    }
    
    public static func instantiateWithBundle(withOwner ownerOrNil: Any? = nil, bundle: Bundle? = nil) -> Base {
        
        let nib = UINib.init(nibName: Base.ex.className(), bundle: bundle)
        return nib.instantiate(withOwner: ownerOrNil, options: nil).first as! Base
    }
    
    public static func instantiateUiView(withOwner ownerOrNil: Any? = nil) -> UIView {

        let nib = UINib.init(nibName: Base.ex.className(), bundle: nil)
        return nib.instantiate(withOwner: ownerOrNil, options: nil).first as! UIView
    }
    
    public static func instantiateUiView(withOwner ownerOrNil: Any? = nil, bundle: Bundle) -> UIView {
        
        let nib = UINib.init(nibName: Base.ex.className(), bundle: bundle)
        return nib.instantiate(withOwner: ownerOrNil, options: nil).first as! UIView
    }
    
    public enum FadeInSpped: Double {
        case slow = 0.2
        case normal = 0.1
        case fast = 0.05
    }
    
    public func fadeIn(duration: FadeInSpped, completed: (() -> Void)? = nil) {
        
        base.alpha = 0
        base.isHidden = false
        UIView.animate(
            withDuration: duration.rawValue,
            animations: { self.base.alpha = 1 },
            completion: { _ in completed?() }
        )
    }
    
    public func expandAnimation(duration: Double = 0.5) {
        UIView.animate(withDuration: duration, animations: {
            self.base.setNeedsDisplay()
            self.base.layoutIfNeeded()
        })
    }
    
    public func scaleImageSize(imageView: UIImageView) -> CGSize {
        guard let imageWidth = imageView.image?.size.width,
            let imageHeight = imageView.image?.size.height
            else { return base.frame.size }
        let frameWidth = base.frame.width
        let frameHeight = base.frame.height
        
        if imageWidth / imageHeight < frameWidth / frameHeight {
            let height = frameHeight
            let width = imageWidth * frameHeight / imageHeight
            return CGSize(width: width, height: height)
        } else {
            let width = frameWidth
            let height = imageHeight * frameWidth / imageWidth
            return CGSize(width: width, height: height)
        }
    }
}
