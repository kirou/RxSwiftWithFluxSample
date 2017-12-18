import Foundation
import SwiftDate

private let region: Region = {
    
    let tz = TimeZoneName.currentAutoUpdating.timeZone
    let cal = CalendarName.gregorian.calendar
    let loc = Locale.autoupdatingCurrent
    return Region(tz: tz, cal: cal, loc: loc)
}()

extension Date: ExtensionCompatible { }

public extension Extension where Base == Date {
    
    public func stringToDateInRegion(string: String, format: String) -> DateInRegion? {
        return DateInRegion(
            string: string,
            format: .custom(format),
            fromRegion: region
        )
    }
    
    public func toString(format: String = "yyyy-M-d HH:mm") -> String {
        let date = DateInRegion(absoluteDate: base, in: region)
        return date.string(custom: format)
    }
    
    public func toDateInRegion() -> DateInRegion {
        return DateInRegion(absoluteDate: base, in: region)
    }
    
    public func stringChangeFormat(string: String, format: String) -> String? {
        guard let dateInRegion = stringToDateInRegion(string: string, format: format) else {
            return nil
        }
        return dateInRegion.string(custom: format)
    }
    
    public func stringToDate(string: String, format: String) -> Date? {
        return DateInRegion(
            string: string,
            format: .custom(format),
            fromRegion: region
        )?.absoluteDate
    }
    
    public static func isWithInPeriod(from: Date?, to: Date?, comparison: Date? = nil) -> Bool {
        
        /// 開始日が無い場合は期間外
        guard let from = from else { return false }
        
        /// 終了日が無い場合は常に期間内
        guard let to = to else { return true }
        
        /// 比較対象が無い場合は、今日の日時
        let needle: Date
        if let comparison = comparison {
            needle = comparison
        } else {
            needle = Date()
        }

        /// 期間内である
        if from <= needle && needle <= to {
            return true
        }

        return false
    }
}
