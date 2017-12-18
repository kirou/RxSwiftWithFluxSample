import Foundation
import Alamofire
import Library

protocol Decodable {
    associatedtype ResponseType
    func decode(data: Any?) -> ResponseType
}

protocol Requestable: URLRequestConvertible {
   
    var baseUrl: String { get }
    var endPoint: String { get }
    var httpMethod: HTTPMethod { get }
    var params: Parameters { get }
    var acceptHeaders: HTTPHeaders { get }
    var addHttpHeaders: HTTPHeaders { get }
}

extension Requestable {
    
    var baseUrl: String {
        return ApiConfig.url
    }
    
    var params: Parameters {
        return [:]
    }
    
    var requestBodyParam: Parameters {
        return [:]
    }
    
    var acceptHeaders: HTTPHeaders {
        return ["Accept": "application/json"]
    }
    
    var addHttpHeaders: HTTPHeaders {
        return [:]
    }
    
    var urlPath: String {
        return "\(baseUrl)\(endPoint)"
    }
    
    var url: URL? {
        return URL(string: urlPath)
    }
    
    var queue: DispatchQueue {
        return DispatchQueue.global(qos: .background)
    }
    
    func asURLRequest() throws -> URLRequest {
        
        guard let url = url else {
            throw Errors.invalidRequest.createError(title: "invalid url.")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.timeoutInterval = ApiConfig.timeout
        
        /// パラメータによるリクエスト
        if params.count > 0 {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: params)
        /// Request Bodyによるリクエスト
        } else {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)
        }

        var headers = acceptHeaders
        for (key, val) in addHttpHeaders {
            headers[key] = val
        }
        
        for (key, val) in headers {
            urlRequest.addValue(val, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
}
