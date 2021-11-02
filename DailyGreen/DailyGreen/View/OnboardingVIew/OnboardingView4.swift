//
//  OnboardingView4.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/01.
//
import UIKit

class OnboardingView4: UIView{
    
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
        label.text = "넷"
        label.textColor = UIColor.dark2
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: NanumFont.bold, size: 24)
        label.text = "시작하기"
        return label
    }()

    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "작은 실천부터 한걸음!           자, 이제 한번 시작해볼까요?"
        
        let attrString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: NanumFont.bold, size: 17)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let startButton: UIButton = { // 임시
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("시작하기", for: .normal)
        return btn
    }()
    
    let startButtonView: UIImageView = { // 임시
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.primary
        view.layer.cornerRadius = 24;
        
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
        addSubview(titleLabel)
        addSubview(indexLabel)
        addSubview(subTitleLabel)
        addSubview(bodyLabel)
        addSubview(startButtonView)
        addSubview(startButton)
        
        NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 91.9),
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                indexLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
                indexLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                subTitleLabel.topAnchor.constraint(equalTo: indexLabel.bottomAnchor, constant: 112),
                
                bodyLabel.widthAnchor.constraint(equalToConstant: 220),
                bodyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                bodyLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 36),
                
                startButtonView.widthAnchor.constraint(equalToConstant: 343),
                startButtonView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150),
                startButtonView.centerXAnchor.constraint(equalTo: centerXAnchor),
                startButtonView.heightAnchor.constraint(equalToConstant: 48),
                startButton.leadingAnchor.constraint(equalTo: startButtonView.leadingAnchor),
                startButton.trailingAnchor.constraint(equalTo: startButtonView.trailingAnchor),
                startButton.topAnchor.constraint(equalTo: startButtonView.topAnchor),
                startButton.bottomAnchor.constraint(equalTo: startButtonView.bottomAnchor)
                
            ])
    }
    
}
