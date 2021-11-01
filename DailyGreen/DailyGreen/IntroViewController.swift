//
//  IntroViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/01.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    let onBoardingViews = [OnboardingView1(), OnboardingView2(), OnboardingView3(), OnboardingView4()]
    
       override func viewDidLoad() {
           super.viewDidLoad()
           setPageControl()
           scrollView.delegate = self
           addContentScrollView()
       }
    
       
       private func addContentScrollView() {
           
           for i in 0..<onBoardingViews.count {
               let xPos = self.view.frame.width * CGFloat(i)
               onBoardingViews[i].frame = CGRect(x:xPos, y:0, width: scrollView.bounds.width, height: scrollView.bounds.height)
               scrollView.addSubview(onBoardingViews[i])
               scrollView.contentSize.width = onBoardingViews[i].frame.width * CGFloat(i + 1)
               if i == 3{
                   guard let onBoardingView = onBoardingViews[3] as? OnboardingView4 else{return}
                   onBoardingView.startButton.addTarget(self, action: #selector(startButtonClicked(_:)), for: .touchUpInside)
               }
           }
       }
       
       private func setPageControl() {
           self.pageController.numberOfPages = 4
           self.pageController.pageIndicatorTintColor =
           UIColor.primary
       }
       
       private func setPageControlSelectedPage(currentPage:Int) {
           pageController.currentPage = currentPage
           pageController.currentPageIndicatorTintColor = UIColor.dark1
       }
    
    @objc func startButtonClicked(_ sender: UIButton){
        guard let LoginVC = self.presentingViewController?.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController else{return}
        self.presentingViewController?.changeRootViewController(LoginVC)
    }
}
extension IntroViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
}
