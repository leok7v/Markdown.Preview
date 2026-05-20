import SwiftUI
import UIKit

extension NativeText: UIViewRepresentable {

    func makeUIView(context: Context) -> UITextView {
        let v = UITextView()
        v.isEditable = false
        v.isSelectable = true
        v.isScrollEnabled = false
        v.backgroundColor = .clear
        v.textContainerInset = .zero
        v.textContainer.lineFragmentPadding = 0
        v.adjustsFontForContentSizeCategory = true
        v.linkTextAttributes = [
            .foregroundColor: UIColor.link,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
        ]
        v.setContentCompressionResistancePriority(.defaultLow,
                                                  for: .horizontal)
        return v
    }

    func updateUIView(_ v: UITextView, context: Context) {
        let next = resolved()
        if v.attributedText?.isEqual(to: next) != true {
            v.attributedText = next
            v.invalidateIntrinsicContentSize()
        }
    }

}

extension NativeText {

    var primaryColor: UIColor { UIColor.label }
    var secondaryColor: UIColor { UIColor.secondaryLabel }

    func mergeTraits(of source: UIFont, into base: UIFont,
                     bold: Bool) -> UIFont {
        var result = base
        var traits = source.fontDescriptor.symbolicTraits
        traits.formUnion(base.fontDescriptor.symbolicTraits)
        if bold { traits.insert(.traitBold) }
        if let descriptor = base.fontDescriptor
            .withSymbolicTraits(traits) {
            result = UIFont(descriptor: descriptor,
                            size: base.pointSize)
        }
        return result
    }

    func boldFont(_ f: UIFont) -> UIFont {
        var result = f
        var traits = f.fontDescriptor.symbolicTraits
        traits.insert(.traitBold)
        if let d = f.fontDescriptor.withSymbolicTraits(traits) {
            result = UIFont(descriptor: d, size: f.pointSize)
        }
        return result
    }

}
