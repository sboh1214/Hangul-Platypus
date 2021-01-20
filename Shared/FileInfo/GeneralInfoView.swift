import SwiftUI

struct GeneralInfoView: View {
    var fileURL: URL?
    @State var isEditable: Bool

    var body: some View {
        Form {
            Text("Hwp File Info")
            Text(fileURL?.absoluteString ?? "Unknown")
            Toggle(isOn: $isEditable) {
                Text("Editable")
            }.disabled(true)
        }
    }
}

struct GeneralInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralInfoView(isEditable: true)
    }
}
