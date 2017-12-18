import Foundation

struct ApiConfig {
    
    static let dateTimeFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ"

    static let url: String = "https://qiita.com/api/v2"
    static let timeout: Double = 10.0

    // リスト系のデフォルト値
    static let start: Int = 1
    static let results: Int = 20
    
    /// 無料連載
    static let itemEndPoint: String = "/items"
    static let userEndPoint: String = "/users"
}
