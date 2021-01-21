import Foundation

extension String {
    // swiftlint:disable identifier_name
    var l: String {
        NSLocalizedString(self, comment: "")
    }
    // swiftlint:enable identifier_name
}
