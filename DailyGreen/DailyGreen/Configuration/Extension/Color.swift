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
    class var grayDisabled: UIColor { UIColor(hex: 0xd2d2d2 )}
    class var primaryLight1: UIColor { UIColor(hex: 0x9bfdbb)}
    class var primaryLight2: UIColor { UIColor(hex: 0x6df59a)}
    class var selected: UIColor { UIColor(hex: 0x9bfdbb, alpha: 0.72)}
    class var grayGreen: UIColor { UIColor(hex: 0xbff6d1)}
    class var grayLongtxt: UIColor { UIColor(hex: 0x7a7e7a)}
    class var error: UIColor { UIColor(hex: 0xff002e)}
    class var dimming: UIColor { UIColor(hex: 0x252525 , alpha: 0.78)}
}
