//
//  OnboardingView2.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/01.
//

import Foundation
import UIKit

class OnboardingView2: UIView{
    let pageIndicator: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "pageIndicator24")
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: NanumFont.bold, size: 24)
        label.text = "일상의 그린이가 되는 방법,"
        let attributedStr = NSMutableAttributedString(string: label.text!)
        attributedStr.addAttribute(.foregroundColor , value: UIColor.dark2, range:(label.text! as NSString).range(of: "그린이") )
        label.attributedText = attributedStr
        return label
    }()
    
    let indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: NanumFont.bold, size: 24)
        label.text = "둘"
        label.textColor = UIColor.dark2
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: NanumFont.bold, size: 24)
        label.text = "함께하기"
        return label
    }()

    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: NanumFont.regular, size: 17)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "여러 친환경 이벤트들에 참여하여         어렵게 느껴졌던 활동들을 다른 사람들과 함께 더 재밌고 쉽게 도전해보세요."
        return label
    }()
    
        
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "ico-ONB2")
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
        addSubview(titleLabel)
        addSubview(indexLabel)
        addSubview(imageView)
        addSubview(subTitleLabel)
        addSubview(bodyLabel)
        addSubview(pageIndicator)
        NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 91.9),
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                indexLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
                indexLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 240),
                imageView.heightAnchor.constraint(equalToConstant: 280),
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageView.topAnchor.constraint(equalTo: indexLabel.topAnchor, constant: 56.3),
                subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                subTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
                bodyLabel.widthAnchor.constraint(equalToConstant: 280),
                bodyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                bodyLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 24),
                pageIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                pageIndicator.widthAnchor.constraint(equalToConstant: 68),
                pageIndicator.heightAnchor.constraint(equalToConstant: 8),
                pageIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -64)
                
                
            ])
    }
    
}
