//
//  LaunchScreenViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/01.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    private lazy var logoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "smileLogo")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        self.view.addSubview(logoView)
        NSLayoutConstraint.activate([
            logoView.widthAnchor.constraint(equalToConstant:  240),
            logoView.heightAnchor.constraint(equalTo: logoView.widthAnchor),
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 180)
        ])
    }
    



}
