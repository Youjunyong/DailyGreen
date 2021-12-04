//
//  CommunityView.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/03.
//

import UIKit

class CommunityView: UIView{
    
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let participateBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("", for: .normal)
        return btn
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: NanumFont.regular, size: 12)
        return label
    }()
    
    override func layoutSubviews() {
        configureUI()
    }
    
    
    private func configureUI(){
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.primaryLight1.cgColor
        self.layer.cornerRadius = 24
        self.backgroundColor = .none
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(participateBtn)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            participateBtn.topAnchor.constraint(equalTo: imageView.topAnchor),
            participateBtn.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            participateBtn.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            participateBtn.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
        ])
    }
    
    
}
