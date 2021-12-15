//
//  CancelAlertView.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/12/15.
//

import UIKit

class CancelAlertView: UIView {
    
    var titleText = ""
    var bodyText = ""
    var image : UIImage?
    
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
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: NanumFont.bold, size: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: NanumFont.bold, size: 17)
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
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    override func layoutSubviews() {
        addSubview(dimmingView)
        addSubview(alertView)
        addSubview(textLabel)
        addSubview(bodyLabel)
        addSubview(dismissBtn)
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            alertView.centerXAnchor.constraint(equalTo: dimmingView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: dimmingView.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 300),
            alertView.heightAnchor.constraint(equalToConstant: 300),
            
            textLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 23),
            textLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -23),
            textLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 44),
            
            bodyLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 4),
            bodyLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 23),
            bodyLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -23),
            
            
            imageView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
            imageView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -30),
            imageView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 30),
            
            dismissBtn.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            dismissBtn.topAnchor.constraint(equalTo: alertView.topAnchor),
            dismissBtn.widthAnchor.constraint(equalToConstant: 44),
            dismissBtn.heightAnchor.constraint(equalToConstant: 44)
        ])
        bodyLabel.text = self.bodyText
        textLabel.text = self.titleText
        let nanum = NanumFont()
        nanum.setLineSpace(label: bodyLabel, space: 4)
        
        if image != nil {
            imageView.image = image
        }
    }
}



    

