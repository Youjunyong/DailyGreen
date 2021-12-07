//
//  ServiceTextViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/30.
//

import UIKit

class ServiceTextViewController: UIViewController {
    
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBAction func dismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.setTitle("", for: .normal)
    }
    
}
