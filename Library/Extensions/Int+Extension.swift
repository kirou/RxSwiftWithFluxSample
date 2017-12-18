import Foundation

extension Int: ExtensionCompatible {}

extension Extension where Base == Int {
    private static var thousandFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSize = 3
        formatter.groupingSeparator = ","
        return formatter
    }

    public var stringWithSeparator: String {
        let number = NSNumber(value: base)
        return type(of: self).thousandFormatter.string(from: number) ?? "0"
    }
}
