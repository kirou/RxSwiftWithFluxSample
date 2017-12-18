import Foundation

/// Homeというページは、どういうオブジェクトを取り扱っているのかを記載している
struct QiitaHomeState {
    
    private(set) var itemList: [QiitaItem] = []
    private(set) var userList: [QiitaUser] = []

    init(itemList: [QiitaItem], userList: [QiitaUser]) {
        
        self.itemList = itemList
        self.userList = userList
    }
}
