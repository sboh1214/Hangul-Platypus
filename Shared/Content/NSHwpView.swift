import SwiftUI
import CoreHwp

struct NSHwpView: NSViewRepresentable {
    typealias NSViewType = NSTextView
    
    var hwpFile: HwpFile

    func makeNSView(context: Context) -> NSViewType {
        let view = NSTextView()
        hwpFile.sectionArray[0].paragraph[0].paraText?.charArray
        return view
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {

    }
}

struct NSHwpViewPreviews: PreviewProvider {
    static var previews: some View {
        NSHwpView(hwpFile: HwpFile())
    }
}
