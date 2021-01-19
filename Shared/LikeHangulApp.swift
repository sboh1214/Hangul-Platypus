import SwiftUI

@main
struct LikeHangulApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: LikeHangulDocument()) { file in
            MainView(document: file.$document)
        }
        .commands {
            ToolbarCommands()
            SidebarCommands()
            CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                Button("한글다운에 관하여...") {
                    
                }
            }
        }
        //        WindowGroup("About") {
        //            AboutView()
        //        }
        
        #if os(macOS)
        Settings {
            PreferencesView()
                .padding(20)
                .frame(width: 375, height: 150)
        }
        #endif
    }
}
