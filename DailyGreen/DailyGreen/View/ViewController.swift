//
//  ViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/01.
//

import UIKit



class ViewController: UIViewController {
    
    var isShowed = false
    
    
    lazy var upperLabel: UILabel = {
        let label = UILabel()
        label.text = "일상그린과 친환경적인 일상을"
        label.font = UIFont(name: NanumFont.bold, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lowerLabel: UILabel = {
        let label = UILabel()
        label.text = "함께 그려보아요"
        label.font = UIFont(name: NanumFont.bold, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isShowed == false{
            animateLabel()
            isShowed = true
        }
       
    }
    

    
    private func configureUI(){
        view.addSubview(upperLabel)
        view.addSubview(lowerLabel)
        NSLayoutConstraint.activate([
            upperLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 314),
            upperLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            lowerLabel.leadingAnchor.constraint(equalTo: upperLabel.leadingAnchor),
            lowerLabel.topAnchor.constraint(equalTo: upperLabel.bottomAnchor, constant: 18)
        ])
    }
    
    
    private func animateLabel(){
        self.upperLabel.alpha = 0
        self.lowerLabel.alpha = 0
        UIView.animate(withDuration: 2) {
            self.upperLabel.alpha = 1;
            self.lowerLabel.alpha = 1;
        } completion: { _ in
            if Storage.isFirstLaunch() {
                guard let OnBoardVC = self.storyboard?.instantiateViewController(withIdentifier: "OnBoardVC")
                as? OnboardViewController else{return}
                self.upperLabel.alpha = 0
                self.lowerLabel.alpha = 0
                OnBoardVC.presentingVC = self
                OnBoardVC.modalPresentationStyle = .fullScreen
                self.present(OnBoardVC, animated: true, completion: nil)
            }
            
        }
    }
    
    func changeToLoginView(){
        self.dismiss(animated: true) {
            guard let LoginNaviVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginNaviVC") as? CustomNavigationController else{return}
            self.changeRootViewController(LoginNaviVC)
        }
        
    }
    

}

