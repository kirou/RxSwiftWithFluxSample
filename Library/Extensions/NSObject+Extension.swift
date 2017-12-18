import Foundation

public extension Extension where Base: NSObject {
    public static func className() -> String {
        return String(NSStringFromClass(Base.self).components(separatedBy: ".").last!)
    }
}
