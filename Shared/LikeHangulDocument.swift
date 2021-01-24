import SwiftUI
import UniformTypeIdentifiers
import CoreHwp
import OLEKit

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
        do {
            hwp = try HwpFile(fromWrapper: configuration.file)
            wrapper = configuration.file
            type = configuration.contentType
        } catch {
            print(error)
            throw CocoaError(.fileReadCorruptFile)
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        throw CocoaError(.persistentStoreSave)
    }
}
