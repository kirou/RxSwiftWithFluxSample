import Foundation
import DataLayer

struct QiitaItemTranslator {
    
    static func translate(data: [QiitaItemResponse]) -> [QiitaItem] {
        
        return data.map { item in
            return self.translate(data: item)
        }
    }
    
    static func translate(data: QiitaItemResponse) -> QiitaItem {
        
        let tags = data.tags.map { tag in
            QiitaTagTranslator.translate(data: tag)
        }

        let user: QiitaUser?
        if let userResponse = data.user {
            user = QiitaUserTranslator.translate(data: userResponse)
        } else {
            user = nil
        }

        return QiitaItem(
            responseBody: data.responseBody,
            coediting: data.coediting,
            commentsCount: data.commentsCount,
            createdAt: data.createdAt,
            group: data.group,
            id: data.id,
            likeCount: data.likeCount,
            numberString: data.numberString,
            title: data.title,
            updateAt: data.updateAt,
            url: data.url,
            user: user,
            tags: tags
        )
    }
}
