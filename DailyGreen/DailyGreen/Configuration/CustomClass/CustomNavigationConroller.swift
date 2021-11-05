//
//  CustomNavigationConroller.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/04.
//

import UIKit

class CustomNavigationController: UINavigationController {
    lazy var leftButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil )
        return button }()

  
    
    var backButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(named: "dismissButton"), style: UIBarButtonItem.Style.plain , target: nil, action: nil)
                                  
        return btn
    }()
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
    
    @objc func buttonTappedAction(){
        print("tapped")
    }
    


}
