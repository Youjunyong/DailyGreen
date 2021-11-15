//
//  BookMarkShopViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/15.
//

import UIKit
import XLPagerTabStrip

class BookMarkShopViewController : UIViewController, IndicatorInfoProvider{
    
    var childNumber: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
      return IndicatorInfo(title: "\(childNumber)")

    }
}
