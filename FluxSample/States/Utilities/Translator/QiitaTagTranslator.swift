import Foundation
import DataLayer

struct QiitaTagTranslator {
    
    static func translate(data: QiitaTagResponse) -> QiitaTag {
        
        return QiitaTag(name: data.name)
    }
}
