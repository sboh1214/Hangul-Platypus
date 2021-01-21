import SwiftUI
import UniformTypeIdentifiers
import CoreHwp

extension UTType {
    static var hwp: UTType {
        #if os(iOS)
        return UTType(importedAs: "kr.co.hancom.hwp")
        #elseif os(macOS)
        return UTType(importedAs: "com.haansoft.HancomOfficeViewer.mac.hwp")
        #endif
    }
}

struct LikeHangulDocument: FileDocument {
    var hwp: HwpFile
    var wrapper: FileWrapper
    var type: UTType

    init() {
        hwp = HwpFile()
        wrapper = FileWrapper()
        type = .hwp
    }

    static var readableContentTypes: [UTType] { [.hwp] }

    init(configuration: ReadConfiguration) throws {
        hwp = try HwpFile(fromWrapper: configuration.file)
        wrapper = configuration.file
        type = configuration.contentType
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        throw CocoaError(.persistentStoreSave)
    }
}
