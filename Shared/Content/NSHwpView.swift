import SwiftUI

struct NSHwpView: NSViewRepresentable {
    typealias NSViewType = NSTextView

    func makeNSView(context: Context) -> NSViewType {
        let view = NSTextView()
        return view
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {

    }
}

struct NSHwpViewPreviews: PreviewProvider {
    static var previews: some View {
        NSHwpView()
    }
}
