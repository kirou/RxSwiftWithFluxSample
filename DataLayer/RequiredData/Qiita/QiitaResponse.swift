import Foundation
import ObjectMapper

public struct QiitaItemResponse: Mappable {
    
    public var responseBody: String?
    public var coediting: Bool?
    public var commentsCount: Int?
    public var createdAt: String?
    public var group: String?
    public var id: String?
    public var likeCount: Int?
    public var itemPrivate: Bool?
    public var numberString: String?
    public var reactionsCount: Int?
    public var title: String?
    public var updateAt: String?
    public var url: URL?
    public var user: QiitaUserResponse?
    public var tags: [QiitaTagResponse] = []
    
    public init() {
    }
    
    public init?(map: Map) {
    }
    
    mutating public func mapping(map: Map) {
        
        responseBody <- map["rendered_body"]
        coediting <- (map["coediting"], ObjectMapperHelper.transformIntToBool)
        commentsCount <- map["comments_count"]
        createdAt <- map["created_at"]
        group <- map["group"]
        id <- map["id"]
        likeCount <- map["likes_count"]
        itemPrivate <- map["private"]
        reactionsCount <- map["reactions_count"]
        title <- map["title"]
        updateAt <- map["updated_at"]
        url <- (map["url"], URLTransform())
        user <- map["user"]
        tags <- map["tags"]
    }
}

public struct QiitaUserResponse: Mappable {
    
    public var description: String?
    public var facebookId: String?
    public var followeesCount: Int?
    public var followersCount: Int?
    public var githubLoginName: String?
    public var id: String?
    public var itemsCount: Int?
    public var linkedInId: Int?
    public var location: String?
    public var name: String?
    public var organization: String?
    public var permanentId: Int?
    public var profileImageUrl: URL?
    public var twitterScreenName: URL?
    public var websiteUrl: URL?
    
    public init() {
    }
    
    public init?(map: Map) {
    }
    
    mutating public func mapping(map: Map) {
        
        description <- map["description"]
        facebookId <- map["facebook_id"]
        followeesCount <- map["followees_count"]
        followersCount <- map["followers_count"]
        githubLoginName <- map["github_login_name"]
        id <- map["id"]
        itemsCount <- map["items_count"]
        linkedInId <- map["linkedin_id"]
        location <- map["location"]
        name <- map["name"]
        organization <- map["organization"]
        permanentId <- map["permanent_id"]
        profileImageUrl <- (map["profile_image_url"], URLTransform())
        twitterScreenName <- (map["twitter_screen_name"], URLTransform())
        websiteUrl <- (map["website_url"], URLTransform())
    }
}

public struct QiitaTagResponse: Mappable {
    
    public var name: String?
    
    public init() {
    }
    
    public init?(map: Map) {
    }
    
    mutating public func mapping(map: Map) {
        
        name <- map["name"]
    }
}
