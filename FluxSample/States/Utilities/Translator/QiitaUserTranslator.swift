import Foundation
import DataLayer

struct QiitaUserTranslator {
    
    static func translate(data: [QiitaUserResponse]) -> [QiitaUser] {
        
        return data.map { user in
            return self.translate(data: user)
        }
    }
    
    static func translate(data: QiitaUserResponse) -> QiitaUser {
        
        return QiitaUser(
            description: data.description,
            facebookId: data.facebookId,
            followeesCount: data.followeesCount,
            followersCount: data.followersCount,
            githubLoginName: data.githubLoginName,
            id: data.id,
            itemsCount: data.itemsCount,
            linkedInId: data.linkedInId,
            location: data.location,
            name: data.name,
            organization: data.organization,
            permanentId: data.permanentId,
            profileImageUrl: data.profileImageUrl,
            twitterScreenName: data.twitterScreenName,
            websiteUrl: data.websiteUrl
        )
    }
}
