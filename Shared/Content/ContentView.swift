import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            #if os(iOS)
            UIHwpView(geometry: geometry)
            #elseif os(macOS)
            NSHwpView(geometry: geometry)
            #endif
        }
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
