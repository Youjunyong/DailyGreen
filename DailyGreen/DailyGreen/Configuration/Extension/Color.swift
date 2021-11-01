//
//  Color.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/01.
//

import UIKit

extension UIColor {
    
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    class var primary: UIColor { UIColor(hex: 0x4CEC81) }
    class var light1: UIColor { UIColor(hex: 0x9BFDBB) }
    class var light2: UIColor { UIColor(hex: 0x6DF59A) }
    class var dark1: UIColor { UIColor(hex: 0x1CC554) }
    class var dark2: UIColor { UIColor(hex: 0x009C34) }
}
