//
//  FeedViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import UIKit
import XLPagerTabStrip

class FeedViewController: UIViewController, IndicatorInfoProvider {
    var childNumber: String = ""

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {

      super.viewDidLoad()
        configureTableView()

    }

    override func didReceiveMemoryWarning() {

      super.didReceiveMemoryWarning()

    }
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let nib = UINib(nibName: "CoCardTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {

      return IndicatorInfo(title: "\(childNumber)")

    }
}
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CoCardTableViewCell else{return UITableViewCell()}
        cell.categoryLabel.text = "피드"
        cell.upperImageView.image = UIImage(named: "testimage1")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 470
    }
}
