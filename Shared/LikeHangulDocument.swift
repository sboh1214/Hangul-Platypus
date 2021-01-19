import SwiftUI
import UniformTypeIdentifiers
import CoreHwp

extension UTType {
    static var hwp: UTType {
        UTType(importedAs: "com.haansoft.HancomOfficeViewer.mac.hwp")
    }
}

struct LikeHangulDocument: FileDocument {
    var hwp: HwpFile

    init() {
        hwp = HwpFile()
    }

    static var readableContentTypes: [UTType] { [.hwp] }

    init(configuration: ReadConfiguration) throws {
        hwp = try HwpFile(fromWrapper: configuration.file)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        throw CocoaError(.persistentStoreSave)
    }
}
