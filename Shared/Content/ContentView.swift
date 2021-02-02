import SwiftUI

struct ContentView: View {
    var body: some View {
        // ScrollView([.horizontal, .vertical]) {
            GeometryReader { geometry in
                #if os(iOS)
                UIHwpView()
                #elseif os(macOS)
                NSHwpView(geometry: geometry)
                #endif
            }
        // }
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
