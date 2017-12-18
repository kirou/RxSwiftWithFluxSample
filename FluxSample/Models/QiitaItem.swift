import Foundation

struct QiitaItem {
    
    /// データはImmutable
    private(set) var responseBody: String?
    private(set) var coediting: Bool?
    private(set) var commentsCount: Int?
    private(set) var createdAt: String?
    private(set) var group: String?
    private(set) var id: String?
    private(set) var likeCount: Int?
    private(set) var numberString: String?
    private(set) var title: String?
    private(set) var updateAt: String?
    private(set) var url: URL?
    private(set) var user: QiitaUser?
    private(set) var tags: [QiitaTag] = []
    
    init (
        responseBody: String?,
        coediting: Bool?,
        commentsCount: Int?,
        createdAt: String?,
        group: String?,
        id: String?,
        likeCount: Int?,
        numberString: String?,
        title: String?,
        updateAt: String?,
        url: URL?,
        user: QiitaUser?,
        tags: [QiitaTag] = []
        ) {
        
        self.responseBody = responseBody
        self.coediting = coediting
        self.commentsCount = commentsCount
        self.createdAt = createdAt
        self.group = group
        self.id = id
        self.likeCount = likeCount
        self.numberString = numberString
        self.title = title
        self.updateAt = updateAt
        self.url = url
        self.user = user
        self.tags = tags
    }
    
    /// ここにApp側で必要な振る舞いが入ってくる
}
