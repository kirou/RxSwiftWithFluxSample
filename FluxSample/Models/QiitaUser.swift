import Foundation

struct QiitaUser {
    
    /// データはImmutable
    private(set) var description: String?
    private(set) var facebookId: String?
    private(set) var followeesCount: Int?
    private(set) var followersCount: Int?
    private(set) var githubLoginName: String?
    private(set) var id: String?
    private(set) var itemsCount: Int?
    private(set) var linkedInId: Int?
    private(set) var location: String?
    private(set) var name: String?
    private(set) var organization: String?
    private(set) var permanentId: Int?
    private(set) var profileImageUrl: URL?
    private(set) var twitterScreenName: URL?
    private(set) var websiteUrl: URL?
    
    init (
        description: String?,
        facebookId: String?,
        followeesCount: Int?,
        followersCount: Int?,
        githubLoginName: String?,
        id: String?,
        itemsCount: Int?,
        linkedInId: Int?,
        location: String?,
        name: String?,
        organization: String?,
        permanentId: Int?,
        profileImageUrl: URL?,
        twitterScreenName: URL?,
        websiteUrl: URL?
        ) {
        
        self.description = description
        self.facebookId = facebookId
        self.followeesCount = followeesCount
        self.followersCount = followersCount
        self.githubLoginName = githubLoginName
        self.id = id
        self.itemsCount = itemsCount
        self.linkedInId = linkedInId
        self.location = location
        self.name = name
        self.organization = organization
        self.permanentId = permanentId
        self.profileImageUrl = profileImageUrl
        self.twitterScreenName = twitterScreenName
        self.websiteUrl = websiteUrl
    }
    
    /// ここにApp側で必要な振る舞いが入ってくる
}
