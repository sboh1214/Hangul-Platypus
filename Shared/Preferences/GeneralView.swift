import SwiftUI

struct GeneralView: View {
    @AppStorage("general.theme") private var appTheme: AppTheme = .system

    var body: some View {
        Picker("Theme", selection: $appTheme) {
            Text("System").tag(AppTheme.system)
            Text("Light").tag(AppTheme.light)
            Text("Dark").tag(AppTheme.dark)
        }
    }
}

struct GeneralViewPreviews: PreviewProvider {
    static var previews: some View {
        GeneralView()
    }
}
