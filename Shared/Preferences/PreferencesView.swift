import SwiftUI

struct PreferencesView: View {
    private enum Tabs: Hashable {
        case general
        case advanced
    }
    var body: some View {
        TabView {
            GeneralView()
                .tabItem {
                    Label("preferences.general".l, systemImage: "gear")
                }
                .tag(Tabs.general)
            AdvancedView()
                .tabItem {
                    Label("preferences.advanced".l, systemImage: "star")
                }
                .tag(Tabs.advanced)
        }
    }
}

struct PreferencesViewPreviews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
