import SwiftUI

struct PreferencesView: View {
    private enum Tabs: Hashable {
        case general, advanced
    }
    var body: some View {
        TabView {
            GeneralView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
            AdvancedView()
                .tabItem {
                    Label("Advanced", systemImage: "star")
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
