import SwiftUI

struct UIHwpView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    func makeUIView(context: Context) -> UIViewType {
        let view = UIView()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct UIHwpView_Previews: PreviewProvider {
    static var previews: some View {
        UIHwpView()
    }
}
