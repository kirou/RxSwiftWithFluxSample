import Foundation

public enum Errors: Error {
    
    case invalidRequest
    case emptyData
    case offline
    case systemError
    case timeout
    
    public var code: Int {
        switch self {
        case .invalidRequest :
            return 400
        case .emptyData :
            return 404
        case .timeout:
            return 408
        case .offline :
            return 503
        default :
            return 500
        }
    }
    
    public func createError(title: String, message: String = "") -> Error {
        
        let domain = "jp.co.tamayuru.hogehoge"
        
        let useInfo = [
            NSLocalizedDescriptionKey: title,
            NSLocalizedFailureReasonErrorKey: message
        ]
        
        return NSError(domain: domain, code: code, userInfo: useInfo)
    }
}
