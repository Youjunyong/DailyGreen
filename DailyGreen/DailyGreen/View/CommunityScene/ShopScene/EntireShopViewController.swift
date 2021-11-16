//
//  EntireShopViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/15.
//

import UIKit
import XLPagerTabStrip

class EntireShopViewController : UIViewController, IndicatorInfoProvider{
    
    @IBOutlet weak var tableView: UITableView!
    var childNumber: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "EntireShopTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EntireCell")
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
      return IndicatorInfo(title: "\(childNumber)")

    }
}
extension EntireShopViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntireCell") as? EntireShopTableViewCell else{return UITableViewCell()}
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 207
    }
    
    
}
