import SwiftUI

struct GeneralView: View {
    @State private var selectedTheme = Theme.system
    
    var body: some View {
        Picker("Theme", selection: $selectedTheme) {
            Text("System").tag(Theme.system)
            Text("Light").tag(Theme.light)
            Text("Dark").tag(Theme.dark)
        }
    }
}

enum Theme: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { self.rawValue }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView()
    }
}
