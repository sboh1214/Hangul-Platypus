import SwiftUI

struct ContentView: View {
    var body: some View {
        #if os(iOS)
        UIHwpView()
        #elseif os(macOS)
        NSHwpView()
        #endif
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
