//
//  CustomNavigationConroller.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/04.
//

import UIKit

class RegisterNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidLayoutSubviews() {
        self.navigationBar.barTintColor = .white
        self.navigationBar.tintColor = .black
        self.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: NanumFont.bold, size: 17)!
        ]
    }
}
