import Foundation

public struct Extension<Base> {
    let base: Base
    init (_ base: Base) {
        self.base = base
    }
}

public protocol ExtensionCompatible {
    associatedtype Compatible
    static var ex: Extension<Compatible>.Type { get }
    var ex: Extension<Compatible> { get }
}

public extension ExtensionCompatible {
    static var ex: Extension<Self>.Type {
        return Extension<Self>.self
    }
    
    var ex: Extension<Self> {
        return Extension(self)
    }
}
