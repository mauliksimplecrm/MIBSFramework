//
//  AttributedString.swift
//  Maisarah
//
//  Created by Maulik Vora on 21/01/22.
//

import Foundation
import UIKit

extension String {
    

    //--
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
    func attributedStringWithColorNew(_ location: Int, length: Int, color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location:location,length:length))
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
    func underlineWords(words: [String], color: UIColor) -> NSAttributedString{
        let underLineStyle = NSUnderlineStyle.single.rawValue
        let attributedText = NSMutableAttributedString(string: self)
        for word in words {
            let rangeToUnderline = (self as NSString).range(of: word)
            
            let underlineAttributes = [
                NSAttributedString.Key.underlineStyle: underLineStyle,
                NSAttributedString.Key.underlineColor: color
            ] as [NSAttributedString.Key : Any]
            attributedText.addAttributes(underlineAttributes, range: rangeToUnderline)
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: rangeToUnderline)
        }
        return attributedText
    }
}
