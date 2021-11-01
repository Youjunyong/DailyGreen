//
//  ViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/01.
//

import UIKit

class ViewController: UIViewController {

    let testLabel: UILabel = {
       
        let label = UILabel()
        label.text = "시험 텍스트"
        label.font = UIFont(name: NanumFont.bold, size: 40)
//        UIFont.systemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let testLabel2: UILabel = {
       
        let label = UILabel()
        label.text = "시험 텍스트"
        label.font = UIFont(name: NanumFont.acBold, size: 40)
//        UIFont.systemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(testLabel)
        view.addSubview(testLabel2)
        
        NSLayoutConstraint.activate([
            testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testLabel2.centerYAnchor.constraint(equalTo: testLabel.bottomAnchor, constant: 30),
            testLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }


}

