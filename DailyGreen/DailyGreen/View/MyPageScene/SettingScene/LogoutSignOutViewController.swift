//
//  LogoutSignOutViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/22.
//

import UIKit


class LogoutSignOutViewController : UIViewController {
    
    lazy var signOutDataManager = SignOutDataManager()
    
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "jwt")
        UserDefaults.standard.removeObject(forKey: "way")
        UserDefaults.standard.removeObject(forKey: "nickName")
        UserDefaults.standard.removeObject(forKey: "profilePhotoUrl")
        let LoginNaviVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNaviVC")
        
        self.changeRootViewController(LoginNaviVC)
    }
    
    @IBAction func signOut(_ sender: Any) {
        guard let userIdx = UserDefaults.standard.string(forKey: "userIdx") else{return}
        let params = SignOutRequest(userIdx: Int(userIdx)!)
        signOutDataManager.patchSignOut(params, delegate: self, userIdx: Int(userIdx)!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        logoutButton.setTitle("", for: .normal)
        signOutButton.setTitle("", for: .normal)
    }
}


extension LogoutSignOutViewController {
    
    func successToSignOut(message: String){
        presentAlert(title: message)
        UserDefaults.standard.removeObject(forKey: "jwt")
        UserDefaults.standard.removeObject(forKey: "way")
        UserDefaults.standard.removeObject(forKey: "nickName")
        UserDefaults.standard.removeObject(forKey: "profilePhotoUrl")
        let LoginNaviVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNaviVC")
        self.changeRootViewController(LoginNaviVC)
    }
    
    func failedToRequest(message: String){
        presentAlert(title: message)
    }
}
