//
//  CoCardTableViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/12.
//

import UIKit

class CoCardTableViewCell: UITableViewCell {

    var preHashTag: UILabel? = nil
    
    @IBOutlet weak var calendarImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var centerDivideView: UIView!
    @IBOutlet weak var participateButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upperImageView: UIImageView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var maxPeopleNum: UILabel!
    @IBOutlet weak var participateLabel: UILabel!
    
    @IBOutlet weak var devideViewConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        
        bodyLabel.textColor = .grayLongtxt
        centerDivideView.backgroundColor = .dark1
        
        upperImageView.layer.cornerRadius = 24
        upperImageView.layer.masksToBounds = true
        upperImageView.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner ]

        participateButton.setTitle("", for: .normal)
        participateLabel.font = UIFont(name: NanumFont.extraBold, size: 17)
        
        participateLabel.text = "참여하기"
        participateLabel.textColor = UIColor.dark2
        categoryLabel.font = UIFont(name: NanumFont.bold, size: 15)
        categoryView.layer.cornerRadius = 18
        categoryView.backgroundColor = .white
        
        
        footerView.layer.cornerRadius = 24
        footerView.layer.borderColor = UIColor.primary.cgColor
        footerView.layer.borderWidth = 2
        
        profileImageView.layer.cornerRadius = 18
        profileImageView.contentMode = .scaleAspectFill
    
        titleLabel.font = UIFont(name: NanumFont.bold, size: 17)
    }

    
    
    func addHashTag(_ text : String){
        let hashTagLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.backgroundColor = .light1
            label.numberOfLines = 1
            label.layer.cornerRadius = 10
            label.font = UIFont.systemFont(ofSize: 13)
            label.text = text
            return label
        }()
        
        addSubview(hashTagLabel)
        
        if preHashTag == nil{
            NSLayoutConstraint.activate([
                hashTagLabel.topAnchor.constraint(equalTo: calendarImageView.bottomAnchor, constant: 10),
                hashTagLabel.leadingAnchor.constraint(equalTo: calendarImageView.leadingAnchor)
            ])
        }else{
            NSLayoutConstraint.activate([
                hashTagLabel.centerYAnchor.constraint(equalTo: preHashTag!.centerYAnchor),
                hashTagLabel.leadingAnchor.constraint(equalTo: preHashTag!.trailingAnchor, constant: 5)
            ])
            
        }
        self.preHashTag = hashTagLabel
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
