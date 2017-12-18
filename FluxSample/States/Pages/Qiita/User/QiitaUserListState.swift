import Foundation

struct QiitaUserListState {
    
    enum PageState {
        case idle
        case loading
        case paging
        case updated
    }
    
    private(set) var page: Int = 1
    private(set) var perPage: Int = 10
    private(set) var nextPage: Int
    private(set) var userList: [QiitaUser] = []
    private(set) var pageState: PageState = .idle

    init(userList: [QiitaUser], page: Int, perPage: Int, pageState: PageState) {
        
        self.userList = userList
        self.page = page
        self.perPage = perPage
        self.pageState = pageState
        self.nextPage = page + 1
    }
}
