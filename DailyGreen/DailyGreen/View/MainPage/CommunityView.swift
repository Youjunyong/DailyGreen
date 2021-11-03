//
//  CommunityView.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/03.
//

import UIKit

class CommunityView: UIView{
    
    var activate = false
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: NanumFont.regular, size: 12)
        return label
    }()
    override func layoutSubviews() {
        configureUI()
        if activate {
            backgroundColor = UIColor.selected
        }
    }
    
    
    private func configureUI(){
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.primaryLight1.cgColor
        self.layer.cornerRadius = 24
        self.backgroundColor = .none
        addSubview(imageView)
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    
}
