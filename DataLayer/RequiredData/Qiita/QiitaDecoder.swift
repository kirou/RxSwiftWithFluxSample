import Foundation
import ObjectMapper
import SwiftyJSON

struct QiitaItemListDecoder: Decodable {
    
    typealias ResponseType = [QiitaItemResponse]?

    func decode(data: Any?) -> ResponseType {
        
        // パース用に向けて型を整形
        guard let responseData = data as? Data else { return nil }
        guard let jsonDecode = try? JSON(data: responseData).object else { return nil }
        return Mapper<QiitaItemResponse>().mapArray(JSONObject: jsonDecode)
    }
}

struct QiitaItemDecoder: Decodable {
    
    typealias ResponseType = QiitaItemResponse?
    
    func decode(data: Any?) -> ResponseType {
        
        // パース用に向けて型を整形
        guard let responseData = data as? Data else { return nil }
        guard let jsonDecode = try? JSON(data: responseData).object else { return nil }
        return Mapper<QiitaItemResponse>().map(JSONObject: jsonDecode)
    }
}

struct QiitaUserListDecoder: Decodable {
    
    typealias ResponseType = [QiitaUserResponse]?
    
    func decode(data: Any?) -> ResponseType {
        
        // パース用に向けて型を整形
        guard let responseData = data as? Data else { return nil }
        guard let jsonDecode = try? JSON(data: responseData).object else { return nil }
        return Mapper<QiitaUserResponse>().mapArray(JSONObject: jsonDecode)
    }
}

struct QiitaUserDecoder: Decodable {
    
    typealias ResponseType = QiitaUserResponse?
    
    func decode(data: Any?) -> ResponseType {
        
        // パース用に向けて型を整形
        guard let responseData = data as? Data else { return nil }
        guard let jsonDecode = try? JSON(data: responseData).object else { return nil }
        return Mapper<QiitaUserResponse>().map(JSONObject: jsonDecode)
    }
}
