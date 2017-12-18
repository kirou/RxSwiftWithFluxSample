import Foundation
import RxSwift
import Alamofire
import Library

final class ApiClient {

    static func execute<T: Requestable, U: Decodable, V>(request:T, decode: U) -> Single<V> where U.ResponseType == V {
        
        return Single<U.ResponseType>.create { single -> Disposable in
            
            guard let urlRequest = try? request.asURLRequest() else {
                single(.error( Errors.systemError.createError(title: "url request error.")))
                return Disposables.create()
            }
            
            dump("urlRequesturlRequesturlRequest")
            dump(urlRequest)
            
            Alamofire
                .request(urlRequest)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json", "text/plain", "application/xml"])
                .responseData(queue: request.queue, completionHandler: { response in
                    
                    switch response.result {
                    case .success:
                        single(.success(decode.decode(data: response.result.value)))
                        break
                    case .failure(let error):
                        single(.error(error))
                        break
                    }
                })
            
            return Disposables.create()
        }
    }
}
