import Foundation

final class MockFile {
    
    static func file(name: String, type: String = "json") -> Data? {
        
        guard let path: String = Bundle.main.path(forResource: name, ofType: "json") else {
            return nil
        }
        
        guard let fileHandle: FileHandle = FileHandle(forReadingAtPath: path) else {
            return nil
        }
        
        return fileHandle.readDataToEndOfFile()
    }
}
