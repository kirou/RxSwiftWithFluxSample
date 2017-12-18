import Foundation

public struct QiitaItemListParameter {
    
    var page: Int
    var perPage: Int
    var query: String
    
    var parametes: [String: Any] {
        
        guard query != "" else {
            return ["page": page, "per_page": perPage]
        }
        
        return ["page": page, "per_page": perPage, "query": query ]
    }
    
    public init (page: Int, perPage: Int, query: String = "") {
        
        self.page = page
        self.perPage = perPage
        self.query = query
    }
}

public struct QiitaItemParameter {
    
    var itemId: String

    var parametes: [String: Any] {
        return ["item_id": itemId]
    }
    
    public init (itemId: String) {
        
        self.itemId = itemId
    }
}

public struct QiitaUserListParameter {
    
    var page: Int
    var perPage: Int

    var parametes: [String: Any] {
        return [
            "page": page,
            "per_page": perPage
        ]
    }
    
    public init (page: Int, perPage: Int) {
        
        self.page = page
        self.perPage = perPage
    }
}

public struct QiitaUserParameter {
    
    var id: String

    var parametes: [String: Any] {
        return [
            "id": id
        ]
    }
    
    public init (id: String) {
        
        self.id = id
    }
}
