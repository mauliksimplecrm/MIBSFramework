
//
//  Image.swift
//  Maisarah
//
//  Created by Maulik Vora on 29/01/22.
//

import Foundation
import UIKit

extension UIImage
{
    static let IMGDoneGreen = UIImage(named: "ic_fill_correct_green", in: bundleIdentifireGlob, with: nil)
    static let IMGDropDownGreen = UIImage(named: "ic_dropdown_green", in: bundleIdentifireGlob, with: nil)
    static let IMGValidationRed = UIImage(named: "ic_fill_validation", in: bundleIdentifireGlob, with: nil)
    
    static let IMGCheckGreen = UIImage(named: "ic_check_green", in: bundleIdentifireGlob, with: nil)
    static let IMGUnCheckGray = UIImage(named: "ic_uncheck_gray", in: bundleIdentifireGlob, with: nil)
    
    static let IMGRadioFill = UIImage(named: "ic_radio_fill", in: bundleIdentifireGlob, with: nil)
    static let IMGRadioUnFill = UIImage(named: "ic_radio_unfill", in: bundleIdentifireGlob, with: nil)
}

extension UIImage{
    func convertImageToBase64String (compressionQuality: CGFloat = 0.7) -> String {
        if let imageData = self.jpegData(compressionQuality: compressionQuality) {
            let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
            return "data:image/jpeg;base64,\(imgString)"
        }else{
            return ""
        }
    }
}
extension UIImage {

    public enum DataUnits: String {
        case byte, kilobyte, megabyte, gigabyte
    }

    func getSizeIn(_ type: DataUnits)-> String {

        guard let data = self.pngData() else {
            return ""
        }

        var size: Double = 0.0

        switch type {
        case .byte:
            size = Double(data.count)
        case .kilobyte:
            size = Double(data.count) / 1000
        case .megabyte:
            size = Double(data.count) / 1000 / 1000
        case .gigabyte:
            size = Double(data.count) / 1000 / 1000 / 1000
        }

        return String(format: "%.2f", size)
    }
}
