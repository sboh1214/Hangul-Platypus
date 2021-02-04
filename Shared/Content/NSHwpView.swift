import SwiftUI
import CoreHwp
import SnapKit

struct NSHwpView: NSViewRepresentable {
    typealias NSViewType = NSScrollView

    @EnvironmentObject var file: FileObject
    var geometry: GeometryProxy

    func makeNSView(context: Context) -> NSViewType {
        // context.environment.colorScheme == .light
        let hwp = file.document.wrappedValue.hwp

        let textStorage = NSTextStorage(attributedString: makeStringForStorage(from: hwp))
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        let containerSize = CGSize(width: 1000, height: 1000)
        let container = NSTextContainer(size: containerSize)
        container.widthTracksTextView = false
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)

        let scrollView = NSScrollView()
        scrollView.borderType = .noBorder
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.hasHorizontalRuler = true

        let clipView = NSClipView()
        scrollView.contentView = clipView
        clipView.snp.makeConstraints { $0.edges.equalTo(scrollView) }

        let textView = NSTextView(frame: NSRect(x: 0, y: 0, width: 300, height: 300), textContainer: container)
        textView.isEditable = false
        textView.isRichText = true
        textView.isSelectable = true
        scrollView.documentView = textView
        textView.snp.makeConstraints { $0.top.equalTo(clipView) }
        textView.snp.makeConstraints {$0.centerY.equalTo(clipView)}

        return scrollView
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {

    }
}

struct NSHwpViewPreviews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            NSHwpView(geometry: geometry)
        }
    }
}
