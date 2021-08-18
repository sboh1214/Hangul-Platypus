import SwiftUI
import CoreHwp

struct UIHwpView: UIViewRepresentable {
    typealias UIViewType = UIScrollView

    @EnvironmentObject var file: FileObject

    func makeUIView(context: Context) -> UIViewType {
        let hwp = file.document.wrappedValue.hwp
        let textViewManager = TextViewManager(from: hwp)

        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 1000, height: 2000), textContainer: textViewManager.textContainer)
        textView.isEditable = false
        textView.isSelectable = true
        textView.isScrollEnabled = false

        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.addSubview(textView)

        let constraints = [
            textView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            textView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            textView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ]
        scrollView.addConstraints(constraints)

        return scrollView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}

struct UIHwpViewPreviews: PreviewProvider {
    static var previews: some View {
        UIHwpView()
    }
}
