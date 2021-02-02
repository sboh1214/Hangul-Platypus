import SwiftUI
import CoreHwp

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

                var index = 0
                while true {
                    let rangeCharArray: ArraySlice<HwpChar>
                    if index == paragraph.paraCharShape.startingIndex.count - 1 {
                        let startIndex = Int(paragraph.paraCharShape.startingIndex[index])
                        rangeCharArray = charArray[startIndex..<charArray.endIndex]
                    } else {
                        let startIndex = Int(paragraph.paraCharShape.startingIndex[index])
                        let endIndex = Int(paragraph.paraCharShape.startingIndex[index + 1])
                        rangeCharArray = charArray[startIndex..<endIndex]
                    }

                    let characterArray = rangeCharArray.compactMap { char -> Character? in
                        if char.type == .char {
                            return Character(UnicodeScalar(char.value)!)
                        } else {
                            return Character(UnicodeScalar(UInt16(32))!) // Space
                        }
                    }

                    let string = String(characterArray)
                    let attributedString = NSMutableAttributedString(string: string)
                    let range = (string as NSString).range(of: string)

                    let attribute = hwp.docInfo.idMappings.charShapeArray[Int(paragraph.paraCharShape.shapeId[index])]

                    if attribute.property.isBold {
                        let font = NSFont.boldSystemFont(ofSize: 16)
                        attributedString.addAttribute(.font, value: font, range: range)
                    }

                    allString.append(attributedString)

                    if index < paragraph.paraCharShape.startingIndex.count - 1 {
                        index += 1
                    } else {
                        break
                    }
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
