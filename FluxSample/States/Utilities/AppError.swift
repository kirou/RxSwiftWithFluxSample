import Foundation

struct AppError: Error {
    
    private(set) var message: String?
    
    init(message: String?) {
        self.message = message
    }
}
