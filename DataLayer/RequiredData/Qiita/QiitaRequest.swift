import Foundation
import Alamofire

enum QiitaRequest: Requestable {
    
    // IF
    case item(inputParameter: QiitaItemParameter)
    case itemList(inputParameter: QiitaItemListParameter)
    case user(inputParameter: QiitaUserParameter)
    case userList(inputParameter: QiitaUserListParameter)

    var httpMethod: HTTPMethod { return .get }
    
    var endPoint: String {
        switch self {
        case .item(let inputParameter):
            return "\(ApiConfig.itemEndPoint)/\(inputParameter.itemId)"
        case .itemList:
            return ApiConfig.itemEndPoint
        case .user(let inputParameter):
            return "\(ApiConfig.userEndPoint)/\(inputParameter.id)"
        case .userList:
            return ApiConfig.userEndPoint
        }
    }
    
    var params: Parameters {
        switch self {
        case .itemList(let inputParameter):
            return inputParameter.parametes
        case .userList(let inputParameter):
            return inputParameter.parametes
        default:
            return [:]
        }
    }
}
