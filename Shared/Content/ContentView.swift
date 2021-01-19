import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            #if os(iOS)
            UIHwpView()
            #elseif os(macOS)
            NSHwpView()
            #endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
