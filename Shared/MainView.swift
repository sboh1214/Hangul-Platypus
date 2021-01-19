import SwiftUI

struct MainView: View {
    @Binding var document: LikeHangulDocument

    @State var isFileInfoPresented: Bool = false

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
                Button(action: {isFileInfoPresented = true}, label: {
                    Image(systemName: "info.circle")
                })
            }
        }.sheet(isPresented: $isFileInfoPresented) {
            FileInfoView(header: document.hwp.fileHeader, toggleSheet: {isFileInfoPresented = false})
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
