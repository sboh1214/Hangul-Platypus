import CoreHwp
import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

#if canImport(SwiftUI)
import SwiftUI
#endif

extension HwpColor {
    var cgColor: CGColor {
        get {
            let red = CGFloat(self.red) / CGFloat(255)
            let green = CGFloat(self.green) / CGFloat(255)
            let blue = CGFloat(self.blue) / CGFloat(255)
            let alpha = CGFloat(1)
            return CGColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }

    #if os(iOS)
    var uiColor: UIColor {
        get {
            return UIColor(cgColor: self.cgColor)
        }
    }
    #endif

    #if os(macOS)
    var nsColor: NSColor {
        get {
            return NSColor(cgColor: self.cgColor)!
        }
    }
    #endif

    #if canImport(SwiftUI)
    var color: Color {
        get {
            return Color(self.cgColor)
        }
    }
    #endif
}
