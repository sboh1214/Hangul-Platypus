import SwiftUI

struct UIHwpView: UIViewRepresentable {
    typealias UIViewType = UITextView

    @EnvironmentObject var file: FileObject
    var geometry: GeometryProxy

    func makeUIView(context: Context) -> UIViewType {
        let hwp = file.document.wrappedValue.hwp

        let textStorage = NSTextStorage(attributedString: makeStringForStorage(from: hwp))
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        let containerSize = CGSize(width: geometry.size.width, height: .greatestFiniteMagnitude)
        let container = NSTextContainer(size: containerSize)
        container.widthTracksTextView = true
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)

        let view = UITextView(frame: geometry.frame(in: .local), textContainer: container)
        view.isEditable = false
        view.isSelectable = true
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = true
        view.maximumZoomScale = 3
        view.minimumZoomScale = 0.5

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}

struct UIHwpViewPreviews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            UIHwpView(geometry: geometry)
        }
    }
}
