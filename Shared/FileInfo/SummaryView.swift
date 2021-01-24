import SwiftUI

struct SummaryView: View {
    var body: some View {
        Form {
            HStack {
                Label("제목", systemImage: "bolt.fill")
                Text("Unknown")
            }
            HStack {
                Label("주제", systemImage: "bolt.fill")
                Text("Unknown")
            }
            HStack {
                Label("지은이", systemImage: "bolt.fill")
                Text("Unknown")
            }
        }
    }
}

struct SummaryViewPreviews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
