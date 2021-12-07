//
//  EventCollectionViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/02.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dimmingView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }
    
    private func configureUI(){
        typeLabel.font = UIFont(name: NanumFont.bold, size: 15)
        detailButton.setTitle("", for: .normal)
        typeView.layer.cornerRadius = 18
        dimmingView.layer.cornerRadius = 16
        imageView.layer.cornerRadius = 16
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: NanumFont.bold, size: 17)
        locationLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        locationLabel.textColor = .white
        dateLabel.textColor = .white
        
        
        dimmingView.backgroundColor = .dimmingView
        
        shadowView.layer.cornerRadius = 16
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.24
        shadowView.layer.shadowRadius = 2
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        
    }

}
