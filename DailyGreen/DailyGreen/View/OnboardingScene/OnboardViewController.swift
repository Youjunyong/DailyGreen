//
//  IntroViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/01.
//

import UIKit

class OnboardViewController: UIViewController {

    var presentingVC: ViewController?
    
    @IBOutlet weak var contentViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentWidthConstraint: NSLayoutConstraint!
    let onBoardingViews = [OnboardingView1(), OnboardingView2(), OnboardingView3(), OnboardingView4()]
    
       override func viewDidLoad() {
           super.viewDidLoad()
           addContentScrollView()
       }
    
       private func addContentScrollView() {
           contentWidthConstraint.constant = self.view.frame.width * 4
           for i in 0..<onBoardingViews.count {
               let xPos = self.view.frame.width * CGFloat(i)
               let width = self.view.frame.width
               onBoardingViews[i].frame = CGRect(x:xPos, y:0, width: width, height: scrollView.bounds.height)
               scrollView.addSubview(onBoardingViews[i])
               scrollView.contentSize.width = onBoardingViews[i].frame.width * CGFloat(i + 1)
               if i == 3{
                   guard let onBoardingView = onBoardingViews[3] as? OnboardingView4 else{return}
                   onBoardingView.startButton.addTarget(self, action: #selector(startButtonClicked(_:)), for: .touchUpInside)
               }
           }
       }
       
    
    @objc func startButtonClicked(_ sender: UIButton){
        presentingVC?.changeToLoginView()
    }
}
