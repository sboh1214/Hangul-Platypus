import SwiftUI

struct GeneralInfoView: View {
    @EnvironmentObject var file: FileObject

    var body: some View {
        Form {
            Section {
                HStack {
                    Label("File Path", systemImage: "bolt.fill")
                    Text(file.fileURL?.absoluteString ?? "Unknown")
                }
                Toggle("Editable", isOn: $file.isEditable).disabled(true)
            }
        }
    }
}

struct GeneralInfoViewPreviews: PreviewProvider {
    static var previews: some View {
        GeneralInfoView()
    }
}
