import SwiftUI

struct GeneralInfoView: View {
    @EnvironmentObject var fileInfo: FileInfoObject

    var body: some View {
        Form {
            Section {
                HStack {
                    Label("File Path", systemImage: "bolt.fill")
                    Text(fileInfo.fileURL?.absoluteString ?? "Unknown")
                }
                Toggle("Editable", isOn: $fileInfo.isEditable).disabled(true)
            }
        }
    }
}

struct GeneralInfoViewPreviews: PreviewProvider {
    static var previews: some View {
        GeneralInfoView()
    }
}
