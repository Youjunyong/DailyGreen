//
//  ModalHeaderView.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/03.
//

import UIKit

class ModalHeaderView: UIView {

    let divideView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.dark1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dismissButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "dismissButton"), for: .normal)
        btn.setTitle("", for: .normal)
        return btn
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: NanumFont.bold, size: 17)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    private func configureUI(){
        addSubview(dismissButton)
        addSubview(titleLabel)
        addSubview(divideView)
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: topAnchor),
            dismissButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            dismissButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            dismissButton.widthAnchor.constraint(equalToConstant:  44.0),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            divideView.bottomAnchor.constraint(equalTo: bottomAnchor),
            divideView.heightAnchor.constraint(equalToConstant: 1.0),
            divideView.leadingAnchor.constraint(equalTo: leadingAnchor),
            divideView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
}
