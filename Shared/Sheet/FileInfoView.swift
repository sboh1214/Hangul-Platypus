import SwiftUI
import CoreHwp

struct FileInfoView: View {
    let header: HwpFileHeader
    let toggleSheet: () -> Void

    var body: some View {
        Text("Hwp File Info")
        Button("Dismiss") {toggleSheet()}
    }
}

struct FileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
        // FileInfoView(header: HwpFileHeader(), toggleSheet: {})
    }
}
