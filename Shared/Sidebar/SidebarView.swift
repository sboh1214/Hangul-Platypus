import SwiftUI

struct SidebarView: View {
    var body: some View {
        TabView {
            PageView().tabItem {
                Label("sidebar.page".l, systemImage: "list.dash")
            }
            TOCView().tabItem {
                Label("sidebar.toc".l, systemImage: "square.and.pencil")
            }
        }
    }
}

struct SidebarViewPreviews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
