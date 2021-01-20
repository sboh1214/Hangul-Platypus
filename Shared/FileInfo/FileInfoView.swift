import SwiftUI
import CoreHwp

struct FileInfoView: View {
    let fileURL: URL?
    let isEditable: Bool
    let document: LikeHangulDocument

    @State private var tabSelection = Tabs.general

    private enum Tabs: Hashable {
        case general
        case summary
        case statistic
        case font
        case picture
        case copyright
    }

    var body: some View {
        TabView(selection: $tabSelection) {
            GeneralInfoView(fileURL: fileURL, isEditable: isEditable)
                .tabItem { Label("일반", systemImage: "star") }.tag(Tabs.general)
            Text("Tab Content 2").tabItem { Label("문서 요약", systemImage: "star") }.tag(Tabs.summary)
            Text("Tab Content 3").tabItem { Label("문서 통계", systemImage: "star") }.tag(Tabs.statistic)
            Text("Tab Content 3").tabItem { Label("글꼴 정보", systemImage: "star") }.tag(Tabs.font)
            Text("Tab Content 3").tabItem { Label("그림 정보", systemImage: "star") }.tag(Tabs.picture)
            Text("Tab Content 3").tabItem { Label("저작권", systemImage: "star") }.tag(Tabs.copyright)
        }.tabViewStyle(DefaultTabViewStyle())
    }
}

struct FileInfoViewPreviews: PreviewProvider {
    static var previews: some View {
        FileInfoView(fileURL: nil, isEditable: false, document: LikeHangulDocument())
    }
}
