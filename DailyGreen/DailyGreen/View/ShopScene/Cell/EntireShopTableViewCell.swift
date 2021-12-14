//
//  EntireShopTableViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/15.
//

import UIKit

class EntireShopTableViewCell: UITableViewCell {

    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var dimmingView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeButtonImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var locationImageView: UIImageView!
    @IBAction func like(_ sender: Any) {
        if likeButtonImageView.image == UIImage(named: "wheart"){
            likeButtonImageView.image = UIImage(named: "wheartFill")
        }
        else{
                likeButtonImageView.image = UIImage(named: "wheart")
            }
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        detailButton.setTitle("", for: .normal)
        dimmingView.backgroundColor = UIColor.dimmingView
        dimmingView.layer.cornerRadius = 12
        shadowView.layer.cornerRadius = 12
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.25
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 4)
        locationImageView.image = UIImage(named: "wlocation")
        likeButtonImageView.image = UIImage(named: "wheart")
        likeButton.setTitle("", for: .normal)
        titleLabel.font = UIFont(name: NanumFont.bold, size: 20)
        titleLabel.textColor = .white
        locationLabel.font = UIFont(name: NanumFont.regular, size: 17)
        locationLabel.textColor = .white
        
        shopImageView.layer.cornerRadius = 12
        shopImageView.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
