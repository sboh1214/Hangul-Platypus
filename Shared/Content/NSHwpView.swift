import SwiftUI
import CoreHwp

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

struct NSHwpView: NSViewRepresentable {
    typealias NSViewType = NSTextView

    @EnvironmentObject var file: FileObject
    var geometry: GeometryProxy

    func makeNSView(context: Context) -> NSViewType {
        // context.environment.colorScheme == .light

        let allString = NSMutableAttributedString(string: "")

        let hwp = file.document.wrappedValue.hwp

        let attribute = hwp.docInfo.idMappings.charShapeArray

        hwp.sectionArray.forEach { section in
            section.paragraph.forEach { paragraph in
                guard let charArray = paragraph.paraText?.charArray else {
                    return
                }

                let rangeArray = makeRange(from: paragraph.paraCharShape.startingIndex, endAt: charArray.endIndex)

                rangeArray.enumerated().forEach { (index, range) in

                    let string = makeString(from: charArray[range])

                    let attribute = hwp.docInfo.idMappings.charShapeArray[Int(paragraph.paraCharShape.shapeId[index])]

                    let attributes: [NSAttributedString.Key: Any] = [
                        .font: makeFont(from: attribute),
                        .foregroundColor: attribute.faceColor.nsColor
                    ]

                    let attributedString = NSMutableAttributedString(string: string, attributes: attributes)

                    allString.append(attributedString)
                }
            }
        }

        let textStorage = NSTextStorage(attributedString: allString)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        let containerSize = CGSize(width: geometry.size.width, height: .greatestFiniteMagnitude)
        let container = NSTextContainer(size: containerSize)
        container.widthTracksTextView = true
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)

        let view = NSTextView(frame: geometry.frame(in: .local), textContainer: container)
        view.isEditable = false
        view.isRichText = true
        view.isSelectable = true

        return view
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {

    }
}

struct NSHwpViewPreviews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            NSHwpView(geometry: geometry)
        }
    }
}
