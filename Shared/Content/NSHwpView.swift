import SwiftUI
import CoreHwp

struct NSHwpView: NSViewRepresentable {
    typealias NSViewType = NSTextView

    @EnvironmentObject var file: FileObject
    var geometry: GeometryProxy

    func makeNSView(context: Context) -> NSViewType {

        // context.environment.colorScheme == .light
        let string = NSAttributedString(string: "Hello")
        let textStorage = NSTextStorage(attributedString: string)

        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        let containerSize = CGSize(width: geometry.size.width, height: .greatestFiniteMagnitude)
        let container = NSTextContainer(size: containerSize)
        container.widthTracksTextView = true
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)

        let view = NSTextView(frame: geometry.frame(in: .local), textContainer: container)
        view.isEditable = false
        view.isRichText = true
        view.isSelectable = true

        return view
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
