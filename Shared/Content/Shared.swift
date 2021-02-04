import Foundation
import CoreHwp
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

func makeRange(from startingIndex: [UInt32], endAt endIndex: Int) -> [Range<Int>] {
    var rangeArray = [Range<Int>]()
    var index = 0
    while true {
        if index == startingIndex.count - 1 {
            let startIndex = Int(startingIndex[index])
            rangeArray.append(startIndex..<endIndex)
        } else {
            let startIndex = Int(startingIndex[index])
            let endIndex = Int(startingIndex[index + 1])
            rangeArray.append(startIndex..<endIndex)
        }

        if index < startingIndex.count - 1 {
            index += 1
        } else {
            break
        }
    }
    return rangeArray
}

func makeString(from charArray: ArraySlice<HwpChar>) -> String {
    let characterArray = charArray.compactMap { char -> Character? in
        if char.type == .char {
            return Character(UnicodeScalar(char.value)!)
        } else {
            return Character(UnicodeScalar(UInt16(32))!) // Space
        }
    }
    return String(characterArray)
}

#if os(iOS)
func makeFont(from attribute: HwpCharShape) -> UIFont {

    let size = CGFloat(attribute.baseSize) * CGFloat(attribute.faceRelativeSize[0]) / CGFloat(10000)

    guard let font = UIFont(name: "HCR Batang", size: size) else {
        print("no font HCR Batang")
        return UIFont.systemFont(ofSize: size)
    }

    let descriptor = font.fontDescriptor
    var traits = descriptor.symbolicTraits

    if attribute.property.isBold {
        traits.insert(.traitBold)
    } else {
        traits.remove(.traitBold)
    }
//    if attribute.property.isItalic {
//        traits.insert(.traitItalic)
//    } else {
//        traits.remove(.traitItalic)
//    }

    guard let modifiedDescriptor = descriptor.withSymbolicTraits(traits) else {
        print("no descriptor HCR Batang")
        return UIFont.systemFont(ofSize: size)
    }
    return UIFont(descriptor: modifiedDescriptor, size: 0)
}
#elseif os(macOS)
func makeFont(from attribute: HwpCharShape) -> NSFont? {
    let family = "HCR Batang"

    let traits: NSFontTraitMask
    if attribute.property.isBold && attribute.property.isItalic {
        traits = [.boldFontMask, .italicFontMask]
    } else if attribute.property.isBold {
        traits = [.boldFontMask, .unitalicFontMask]
    } else if attribute.property.isItalic {
        traits = [.unboldFontMask, .italicFontMask]
    } else {
        traits = [.unboldFontMask, .unitalicFontMask]
    }

    let size = CGFloat(attribute.baseSize) * CGFloat(attribute.faceRelativeSize[0]) / CGFloat(10000)

    let fontManager = NSFontManager.shared
    guard let font = fontManager.font(withFamily: family, traits: traits, weight: 0, size: size)
    else {
        print("no exist")
        return NSFont.systemFont(ofSize: size)
    }
    return font
}
#endif

func makeStrokeWidth(from type: HwpBorderLineType) -> NSNumber {
    switch type {
    case .line:
        return NSNumber(1)
    case .thickLine:
        return NSNumber(2)
    default:
        return NSNumber(0)
    }
}

func makeUnderlineStyle(from property: HwpCharShapeProperty) -> NSUnderlineStyle {
    if property.underlineType == .under {
        switch property.underlineShape {
        default:
            return .single
        }
    } else {
        return []
    }
}

func makeShadow(from charShape: HwpCharShape) -> NSShadow {
    let shadow = NSShadow()
    if charShape.property.shadowType == .none {
        return shadow
    }
    #if os(iOS)
    shadow.shadowColor = charShape.shadowColor.uiColor
    #elseif os(macOS)
    shadow.shadowColor = charShape.shadowColor.nsColor
    #endif
    let width = CGFloat(charShape.shadowIntervalX) / CGFloat(-10)
    let height = CGFloat(charShape.shadowIntervalY) / CGFloat(-10)
    shadow.shadowOffset = CGSize(width: width, height: height)
    return shadow
}

#if os(macOS)
func makeSuperscript(from property: HwpCharShapeProperty) -> NSNumber {
    if property.isSuperscript {
        return NSNumber(1)
    } else if property.isSubscript {
        return NSNumber(-1)
    } else {
        return NSNumber(0)
    }
}
#endif

func makeStrikethroughStyle(from property: HwpCharShapeProperty) -> NSUnderlineStyle {
    switch property.strikethrough {
    case 1:
        return .single
    default:
        return []
    }
}

func makeKerning(from isKerning: Bool) -> CGFloat {
    if isKerning {
        return CGFloat(10)
    } else {
        return CGFloat(0)
    }
}

func makeAttributes(from charShape: HwpCharShape) -> [NSAttributedString.Key: Any] {
    #if os(iOS)
    var attributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: charShape.faceColor.uiColor,
        .strokeColor: charShape.faceColor.uiColor,
        .backgroundColor: charShape.shadeColor.uiColor,
        .underlineColor: charShape.underlineColor.uiColor,
        .strikethroughColor: charShape.strikethroughColor?.uiColor
    ]
    #elseif os(macOS)
    var attributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: charShape.faceColor.nsColor,
        .strokeColor: charShape.faceColor.nsColor,
        .backgroundColor: charShape.shadeColor.nsColor,
        .underlineColor: charShape.underlineColor.nsColor,
        .strikethroughColor: charShape.strikethroughColor?.nsColor,
        .superscript: makeSuperscript(from: charShape.property)
    ]
    #endif

    let sharedAttributes: [NSAttributedString.Key: Any] = [
        .font: makeFont(from: charShape),
        .strokeWidth: makeStrokeWidth(from: charShape.property.borderlineType),
        .underlineStyle: makeUnderlineStyle(from: charShape.property).rawValue,
        .shadow: makeShadow(from: charShape),
        .strikethroughStyle: makeStrikethroughStyle(from: charShape.property).rawValue,
        .kern: makeKerning(from: charShape.property.isKerning)
    ]
    attributes.append(anotherDict: sharedAttributes)
    return attributes
}

func makeStringForStorage(from hwp: HwpFile) -> NSMutableAttributedString {
    let allString = NSMutableAttributedString(string: "")

    hwp.sectionArray.forEach { section in
        section.paragraph.forEach { paragraph in
            guard let charArray = paragraph.paraText?.charArray else {
                return
            }

            let rangeArray = makeRange(from: paragraph.paraCharShape.startingIndex, endAt: charArray.endIndex)

            rangeArray.enumerated().forEach { (index, range) in

                let string = makeString(from: charArray[range])

                let charShape = hwp.docInfo.idMappings.charShapeArray[Int(paragraph.paraCharShape.shapeId[index])]

                let attributedString = NSMutableAttributedString(string: string, attributes: makeAttributes(from: charShape))

                allString.append(attributedString)
            }
        }
    }
    return allString
}

extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    mutating func append(anotherDict: [NSAttributedString.Key: Any]) {
        for (key, value) in anotherDict {
            self.updateValue(value, forKey: key)
        }
    }
}
