import SwiftUI

struct GeneralInfoView: View {
    @EnvironmentObject var fileInfo: FileInfoObject

    var body: some View {
        Form {
            Text("Hwp File Info")
            Text(fileInfo.fileURL?.absoluteString ?? "Unknown")
            Toggle("Editable", isOn: $fileInfo.isEditable)
        }
    }
}

struct GeneralInfoViewPreviews: PreviewProvider {
    static var previews: some View {
        GeneralInfoView()
    }
}
