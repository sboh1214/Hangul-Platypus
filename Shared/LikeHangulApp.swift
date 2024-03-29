import SwiftUI

class FileObject: ObservableObject {
    @Published var document: Binding<LikeHangulDocument>
    @Published var fileURL: URL?
    @Published var isEditable: Bool

    init(document: Binding<LikeHangulDocument>, fileURL: URL?, isEditable: Bool) {
        self.document = document
        self.fileURL = fileURL
        self.isEditable = isEditable
    }
}

enum AppTheme: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    // swiftlint:disable identifier_name
    var id: String { self.rawValue }
    // swiftlint:enable identifier_name
}

@main
struct LikeHangulApp: App {
    @AppStorage("general.theme") private var appTheme: AppTheme = .system
    @Environment (\.colorScheme) var colorScheme: ColorScheme

    var body: some Scene {
        let theme = appTheme == .system ? colorScheme : (appTheme == .light ? ColorScheme.light : ColorScheme.dark )

        DocumentGroup(newDocument: LikeHangulDocument()) { file in
            MainView()
                .environmentObject(FileObject(document: file.$document, fileURL: file.fileURL, isEditable: file.isEditable))
                .colorScheme(theme)
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
                .colorScheme(theme)
                .frame(width: 375, height: 150)
        }
        #endif
    }
}
