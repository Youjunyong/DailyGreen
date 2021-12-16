//
//  OnboardingView2.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/01.
//

import Foundation
import UIKit

class OnboardingView2: UIView{
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "onboarding2")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
    }
    
    // 2. Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureUI()
    }
    
    
    func configureUI(){
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
