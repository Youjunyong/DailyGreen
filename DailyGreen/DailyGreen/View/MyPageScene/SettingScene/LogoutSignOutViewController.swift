//
//  LogoutSignOutViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/22.
//

import UIKit


class LogoutSignOutViewController : UIViewController {
    
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
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton.setTitle("", for: .normal)
        signOutButton.setTitle("", for: .normal)
//        self.navigationController?.viewControllers.removeAll()
        


    }
    
    
}
