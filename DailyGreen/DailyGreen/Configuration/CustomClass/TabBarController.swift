//
//  TabBar.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/03.
//

import UIKit

class TabBarController: UITabBarController {
    
    let divideView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.grayGreen
        return view
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.addSubview(divideView)
        
        NSLayoutConstraint.activate([
            divideView.heightAnchor.constraint(equalToConstant: 2.0),
            divideView.leadingAnchor.constraint(equalTo: self.tabBar.leadingAnchor),
            divideView.trailingAnchor.constraint(equalTo: self.tabBar.trailingAnchor),
            divideView.topAnchor.constraint(equalTo: self.tabBar.topAnchor)
        ])
        self.tabBar.clipsToBounds = true

    }
}
