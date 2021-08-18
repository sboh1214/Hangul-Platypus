#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
import CoreHwp

struct TextViewManager {
    let textStorage: NSTextStorage
    let layoutManager: NSLayoutManager
    let textContainer: NSTextContainer

    init(from hwp: HwpFile) {
        textStorage = NSTextStorage(attributedString: makeStringForStorage(from: hwp))
        layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        let containerSize = CGSize(width: 1000, height: 2000)
        textContainer = NSTextContainer(size: containerSize)
        textContainer.widthTracksTextView = false
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
    }
}
