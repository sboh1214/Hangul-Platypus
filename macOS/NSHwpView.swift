import SwiftUI
import CoreHwp

struct NSHwpView: NSViewRepresentable {
    typealias NSViewType = NSScrollView

    @EnvironmentObject var file: FileObject

    @State var textViewManager: TextViewManager!

    func makeNSView(context: Context) -> NSViewType {
        // context.environment.colorScheme == .light

        let scrollView = NSScrollView()
        let contentSize = scrollView.contentSize
        scrollView.borderType = .noBorder
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.hasHorizontalRuler = true

        let hwp = file.document.wrappedValue.hwp
        let textViewManager = TextViewManager(from: hwp)

        let textView = NSTextView(frame: NSRect(x: 0, y: 0, width: 1000, height: 2000), textContainer: textViewManager.textContainer)
        textView.isEditable = false
        textView.isRichText = true
        textView.isSelectable = true
        textView.breakUndoCoalescing()

        textView.minSize = CGSize(width: 0, height: 0)
        textView.maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = true
        textView.frame = CGRect(x: scrollView.frame.origin.x, y: scrollView.frame.origin.y, width: contentSize.width, height: contentSize.height)
        textView.autoresizingMask = [.width, .height]

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
