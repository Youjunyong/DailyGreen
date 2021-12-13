//
//  OnboardingView4.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/01.
//
import UIKit

class OnboardingView4: UIView{
  

    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "onboarding4")
        view.contentMode = .scaleAspectFit
        return view
    }()
    

    
    let startButton: UIButton = { // 임시
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont(name: NanumFont.extraBold, size: 17)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitle("시작하기", for: .normal)
        return btn
    }()
    
    let startButtonView: UIImageView = { // 임시
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.primary
        view.layer.cornerRadius = 24
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    
    func configureUI(){
        addSubview(imageView)
        addSubview(startButtonView)
        addSubview(startButton)

        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            startButtonView.widthAnchor.constraint(equalToConstant: 343),
            startButtonView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -124),
            startButtonView.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButtonView.heightAnchor.constraint(equalToConstant: 48),
            
            startButton.leadingAnchor.constraint(equalTo: startButtonView.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: startButtonView.trailingAnchor),
            startButton.topAnchor.constraint(equalTo: startButtonView.topAnchor),
            startButton.bottomAnchor.constraint(equalTo: startButtonView.bottomAnchor),
            
        ])
    }
    
}
