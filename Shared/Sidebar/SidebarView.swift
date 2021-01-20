import SwiftUI

struct SidebarView: View {
    var body: some View {
        TabView {
            PageView().tabItem {
                Image(systemName: "list.dash")
            }
            TOCView().tabItem {
                Image(systemName: "square.and.pencil")
            }
        }
    }
}

struct SidebarViewPreviews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
