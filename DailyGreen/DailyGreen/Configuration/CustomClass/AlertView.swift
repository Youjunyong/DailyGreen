//
//  AlertView.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/07.
//

import UIKit

class AlertView: UIView {
    
    var titleText = ""
    var bodyText = ""
    
    let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.dimming
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: NanumFont.bold, size: 18)
        
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: NanumFont.regular, size: 16)
        label.numberOfLines = 0

        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dismissBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "dismissButton"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let defaultLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.text = " ⚠️ 불가피하게 불참해야 하는 경우, 사전에 멤버들에게 오픈채팅방을 통해 알려주세요."
        label.font = UIFont(name: NanumFont.regular, size: 14)
        label.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        return label
    }()
    let underView: UIView = {
       let view = UIView()
        view.backgroundColor = .dark2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func layoutSubviews() {
        addSubview(dimmingView)
        addSubview(alertView)
        addSubview(titleLabel)
        addSubview(bodyLabel)
        addSubview(dismissBtn)
        addSubview(underView)
        addSubview(defaultLabel)
        
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            alertView.centerXAnchor.constraint(equalTo: dimmingView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: dimmingView.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 300),
            alertView.heightAnchor.constraint(equalToConstant: 250),
            
            
            dismissBtn.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            dismissBtn.topAnchor.constraint(equalTo: alertView.topAnchor),
            dismissBtn.widthAnchor.constraint(equalToConstant: 44),
            dismissBtn.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.topAnchor.constraint(equalTo: dismissBtn.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            
            underView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            underView.heightAnchor.constraint(equalToConstant: 2),
            underView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            underView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            
            bodyLabel.topAnchor.constraint(equalTo: underView.bottomAnchor, constant: 20),
            bodyLabel.leadingAnchor.constraint(equalTo: underView.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: underView.trailingAnchor),
            
            defaultLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 30),
            defaultLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            defaultLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16)
            
            
        ])
        titleLabel.text = titleText
        bodyLabel.text = bodyText
        let attrString = NSMutableAttributedString(string: bodyLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        bodyLabel.attributedText = attrString
    }
}



    

