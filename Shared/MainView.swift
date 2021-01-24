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
            #if os(macOS)
            FileInfoView(show: $showFileInfo, document: $document)
                .padding()
            #else
            FileInfoView(show: $showFileInfo, document: $document)
            #endif
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
