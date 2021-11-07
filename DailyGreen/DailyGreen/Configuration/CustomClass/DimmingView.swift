//
//  dimmingView.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/07.
//

import UIKit

class DimmingView: UIView {
    
    var alretText = ""
    
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
        label.textAlignment = .center
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
    
    override func layoutSubviews() {
        addSubview(dimmingView)
        addSubview(alertView)
        addSubview(textLabel)
        addSubview(dismissBtn)
        
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            alertView.centerXAnchor.constraint(equalTo: dimmingView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: dimmingView.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 300),
            alertView.heightAnchor.constraint(equalToConstant: 160),
            
            textLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: alertView.centerYAnchor),
            
            dismissBtn.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            dismissBtn.topAnchor.constraint(equalTo: alertView.topAnchor),
            dismissBtn.widthAnchor.constraint(equalToConstant: 44),
            dismissBtn.heightAnchor.constraint(equalToConstant: 44)
        ])
        textLabel.text = self.alretText
    }
}



    

