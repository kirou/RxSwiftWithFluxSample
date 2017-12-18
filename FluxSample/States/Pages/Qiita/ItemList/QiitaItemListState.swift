import Foundation

struct QiitaItemListState {
    
    enum PageState {
        case idle
        case loading
        case paging
        case updated
    }
    
    private(set) var page: Int = 1
    private(set) var perPage: Int = 10
    private(set) var nextPage: Int
    private(set) var itemList: [QiitaItem] = []
    private(set) var pageState: PageState = .idle

    init(itemList: [QiitaItem], page: Int, perPage: Int, pageState: PageState) {
        
        self.itemList = itemList
        self.page = page
        self.perPage = perPage
        self.pageState = pageState
        self.nextPage = page + 1
    }
}
