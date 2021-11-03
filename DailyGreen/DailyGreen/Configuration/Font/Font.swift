//
//  Font.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/01.
//

import Foundation
import UIKit

struct NanumFont {
    static let bold = "NanumSquareB"
    static let regular = "NanumSquareR"
//    static let extraBold = "NanumSquareEB"
//    static let acBold = "NanumSquareOTF_acB"
    
    
    public func setLineSpace( label: UILabel, space: Int){
        let attrString = NSMutableAttributedString(string: label.text!)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(space)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
    }
    
}



