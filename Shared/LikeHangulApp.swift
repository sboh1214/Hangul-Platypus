import SwiftUI

class FileInfoObject: ObservableObject {
    @Published var fileURL: URL?
    @Published var isEditable: Bool

    init(fileURL: URL?, isEditable: Bool) {
        self.fileURL = fileURL
        self.isEditable = isEditable
    }
}

@main
struct LikeHangulApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: LikeHangulDocument()) { file in
            MainView(document: file.$document)
                .environmentObject(FileInfoObject(fileURL: file.fileURL, isEditable: file.isEditable))
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
