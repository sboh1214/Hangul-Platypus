import SwiftUI

struct MainView: View {
    @Binding var document: LikeHangulDocument

    @State private var showFileInfo = false

    var body: some View {
        NavigationView {
            Group {
                SidebarView()
                ContentView()
            }
        }.sheet(isPresented: $showFileInfo) {
            FileInfoView(show: $showFileInfo, document: $document)
                .padding()
        }.toolbar {
            #if os(macOS)
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar) {
                    Image(systemName: "sidebar.left")
                }
            }
            #endif
            ToolbarItem(placement: .automatic) {
                Button(action: {showFileInfo = true}, label: {
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

struct MainViewPreviews: PreviewProvider {
    static var previews: some View {
        MainView(document: .constant(LikeHangulDocument()))
    }
}
