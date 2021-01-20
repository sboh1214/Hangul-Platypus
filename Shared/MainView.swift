import SwiftUI

struct MainView: View {
    @Binding var document: LikeHangulDocument

    var body: some View {
        NavigationView {
            Group {
                SidebarView()
                ContentView()
            }
        }.toolbar {
            #if os(macOS)
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar) {
                    Image(systemName: "sidebar.left")
                }
            }
            #endif
            ToolbarItem(placement: .automatic) {
                Button(action: {}, label: {
                    Image(systemName: "info.circle")
                })
            }
        }
    }
}

#if os(macOS)
func toggleSidebar() {
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}
#endif

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(document: .constant(LikeHangulDocument()))
    }
}
