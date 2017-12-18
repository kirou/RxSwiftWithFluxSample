import RxSwift

final class Dependencies {
    
    // MARK: - Properties
    
    let mainScheduler = MainScheduler.instance
    let backgroundScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    
    static let shared = Dependencies()
    
    // MARK: - Initializers
    
    private init() {}
}
