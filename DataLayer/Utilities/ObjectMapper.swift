import Foundation
import ObjectMapper
import Library

struct ObjectMapperHelper {
        
    static let transformIntToString = TransformOf<String, Int>(
        fromJSON: {(value:Int?) -> String? in
            if let value = value {
                return String(value)
            }
            return nil
        },
        toJSON: {(value: String?) -> Int? in
            guard let value = value else { return nil }
            return Int(value)
    })
    
    static let transformIntToBool = TransformOf<Bool, Int>(
        fromJSON: {(value:Int?) -> Bool? in
            guard let value = value, value == 1 else { return false }
            return true
    },
        toJSON: {(value: Bool?) -> Int? in
            guard let value = value, value == true else { return 0 }
            return 1
    })
}
