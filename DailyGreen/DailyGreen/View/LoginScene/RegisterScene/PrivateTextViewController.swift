//
//  PolicyTextViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/30.
//

import UIKit
class PrivateTextViewController: UIViewController {
    
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    @IBAction func dismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        dismissButton.setTitle("", for: .normal)
        super.viewDidLoad()
    }
    
    
}
