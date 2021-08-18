import Foundation

extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    mutating func append(anotherDict: [NSAttributedString.Key: Any]) {
        for (key, value) in anotherDict {
            self.updateValue(value, forKey: key)
        }
    }
}
