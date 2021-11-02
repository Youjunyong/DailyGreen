//
//  MainPageViewController.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/02.
//

import UIKit

class MainPageViewController: UIViewController{
    
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    private func configureCollectionView(){
        self.eventCollectionView.dataSource = self
        self.eventCollectionView.delegate = self
        let nib = UINib(nibName: "EventCollectionView", bundle: nil)
        self.eventCollectionView.register(nib, forCellWithReuseIdentifier: "EventCell")
    }
    
    private func configureUI(){
        let userName = "한나"
        userNameLabel.text = "안녕, \(userName)"
        
    }
}
extension MainPageViewController: UICollectionViewDelegate, UICollectionViewFlowLayout {

    
    
}

extension MainPageViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
