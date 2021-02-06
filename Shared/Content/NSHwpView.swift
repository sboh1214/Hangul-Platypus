import SwiftUI
import CoreHwp

struct NSHwpView: NSViewRepresentable {
    typealias NSViewType = NSScrollView

    @EnvironmentObject var file: FileObject

    var textViewManager: TextViewManager!

    func makeNSView(context: Context) -> NSViewType {
        // context.environment.colorScheme == .light
        let hwp = file.document.wrappedValue.hwp
        let textViewManager = TextViewManager(from: hwp)

        let scrollView = NSScrollView()
        scrollView.borderType = .noBorder
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.hasHorizontalRuler = true

        let clipView = NSClipView()
        scrollView.contentView = clipView

        let textView = NSTextView(frame: NSRect(x: 0, y: 0, width: 1000, height: 2000), textContainer: textViewManager.textContainer)
        textView.isEditable = false
        textView.isRichText = true
        textView.isSelectable = true
        scrollView.documentView = textView

        return scrollView
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {

    }
}

struct NSHwpViewPreviews: PreviewProvider {
    static var previews: some View {
        NSHwpView()
    }
}
