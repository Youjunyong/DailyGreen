//
//  ParticipateView.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import UIKit

class ParticipateView: UIView {
    
    let frameView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: NanumFont.bold, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: NanumFont.regular, size : 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let communityImageView: UIImageView  = {
        let view = UIImageView()
//        view.layer.cornerRadius = 72
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let imageFrameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints  = false
        view.layer.cornerRadius = 87
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        return view
    }()
 
    
    let dismissBtn: UIButton = {
        let btn = UIButton()
        let btnImage = UIImage(named: "dismissButton")
        btn.setImage(btnImage, for: .normal)
        btn.setTitle("", for: .normal)
        btn.tintColor = UIColor.black
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let profileImageView1: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.clear.cgColor
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false

        
        return v
    }()
    let profileImageView2: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.clear.cgColor
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false

        

        return v
    }()
    let profileImageView3: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.clear.cgColor
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false

        

        return v
    }()
    
    let followerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followerTrailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "명 참여중"
        return label
    }()
    
    let participateButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("참여하기", for: .normal)
        btn.setTitleColor( UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: NanumFont.extraBold, size: 17)
        return btn
    }()
    
    let participateButtonView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.primary
        view.layer.cornerRadius = 24
        
        return view
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(frameView)
        addSubview(dismissBtn)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(communityImageView)
        addSubview(imageFrameView)
        addSubview(profileImageView1)
        addSubview(profileImageView2)
        addSubview(profileImageView3)
        addSubview(followerLabel)
        addSubview(followerTrailLabel)
        addSubview(participateButtonView)
        addSubview(participateButton)
        
        
        backgroundColor = UIColor.dimming
        NSLayoutConstraint.activate([
            frameView.centerXAnchor.constraint(equalTo: centerXAnchor),
            frameView.centerYAnchor.constraint(equalTo: centerYAnchor),
            frameView.widthAnchor.constraint(equalToConstant: 280),
            frameView.heightAnchor.constraint(equalToConstant: 475),
            
            dismissBtn.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -15),
            dismissBtn.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            dismissBtn.widthAnchor.constraint(equalToConstant: 44),
            dismissBtn.heightAnchor.constraint(equalToConstant: 44),
            
            
            titleLabel.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: 24),
            titleLabel.topAnchor.constraint(equalTo: frameView.topAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: dismissBtn.leadingAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 11),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -24),
            
            communityImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            communityImageView.topAnchor.constraint(equalTo: frameView.topAnchor, constant: 140),
            communityImageView.widthAnchor.constraint(equalToConstant: 144),
            communityImageView.heightAnchor.constraint(equalToConstant: 144),
            
            imageFrameView.centerXAnchor.constraint(equalTo: communityImageView.centerXAnchor),
            imageFrameView.centerYAnchor.constraint(equalTo: communityImageView.centerYAnchor),
            imageFrameView.widthAnchor.constraint(equalToConstant: 174),
            imageFrameView.heightAnchor.constraint(equalToConstant: 174),
            
            profileImageView1.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: 58),
            profileImageView1.topAnchor.constraint(equalTo: communityImageView.bottomAnchor, constant: 60),
            profileImageView1.widthAnchor.constraint(equalToConstant: 20),
            profileImageView1.heightAnchor.constraint(equalToConstant: 20),
            
            profileImageView2.leadingAnchor.constraint(equalTo: profileImageView1.trailingAnchor, constant: -4),
            profileImageView2.centerYAnchor.constraint(equalTo: profileImageView1.centerYAnchor),
            profileImageView2.widthAnchor.constraint(equalToConstant: 20),
            profileImageView2.heightAnchor.constraint(equalToConstant: 20),
            
            profileImageView3.leadingAnchor.constraint(equalTo: profileImageView2.trailingAnchor, constant: -4),
            profileImageView3.centerYAnchor.constraint(equalTo: profileImageView2.centerYAnchor),
            profileImageView3.widthAnchor.constraint(equalToConstant: 20),
            profileImageView3.heightAnchor.constraint(equalToConstant: 20),
            
            
            followerLabel.centerYAnchor.constraint(equalTo: profileImageView1.centerYAnchor),
            followerLabel.leadingAnchor.constraint(equalTo: profileImageView3.trailingAnchor, constant: 10),
            
            followerTrailLabel.centerYAnchor.constraint(equalTo: followerLabel.centerYAnchor),
            followerTrailLabel.leadingAnchor.constraint(equalTo: followerLabel.trailingAnchor, constant: 3),
            
            participateButtonView.bottomAnchor.constraint(equalTo: frameView.bottomAnchor, constant: -24),
            participateButtonView.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: -24),
            participateButtonView.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: 24),
            participateButtonView.heightAnchor.constraint(equalToConstant: 48),
            
            participateButton.leadingAnchor.constraint(equalTo: participateButtonView.leadingAnchor),
            participateButton.trailingAnchor.constraint(equalTo: participateButtonView.trailingAnchor),
            participateButton.topAnchor.constraint(equalTo: participateButtonView.topAnchor),
            participateButton.bottomAnchor.constraint(equalTo: participateButtonView.bottomAnchor)
        ])
        

    }
}
