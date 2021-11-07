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
    static let extraBold = "NanumSquareEB"
//    static let acBold = "NanumSquareOTF_acB"
    
    
    func setLineSpace( label: UILabel, space: Int){
        let attrString = NSMutableAttributedString(string: label.text!)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(space)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
    }
    
    func setSectionFont( label: UILabel, section: String, font: UIFont){
        
        let attrString = NSMutableAttributedString(string: label.text!)
//        attrString.addAttribute(.foregroundColor , value: color, range:(label.text! as NSString).range(of: section))
        attrString.addAttribute(.font, value: font, range: (label.text! as NSString).range(of: section))
        label.attributedText = attrString
    }

    
}



