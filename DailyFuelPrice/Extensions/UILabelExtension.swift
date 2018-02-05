//
//  UILabelExtension.swift
//  aimee
//
//  Created by Chandrachudh on 18/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setPriceToLabel(price:Double) {
        let finalStr = ruppees + "" + String(format:"%.2f",price)
        let ruppeeRange = NSRange.init(location: 0, length: 1)
        
        let attrStr = NSMutableAttributedString.init(string: finalStr)
        attrStr.addAttribute(NSAttributedStringKey.font, value: font.withSize(20), range: ruppeeRange)
        
        attributedText = attrStr
    }
}
