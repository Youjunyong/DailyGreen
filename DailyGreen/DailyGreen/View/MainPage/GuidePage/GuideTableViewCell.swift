//
//  GuideTableViewCell.swift
//  DailyGreen
//
//  Created by 유준용 on 2021/11/03.
//

import UIKit

class GuideTableViewCell: UITableViewCell {

    @IBOutlet weak var lowerview: UIView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var divideView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureUI(){
        btn.setTitle("", for: .normal)
        titleLabel.font = UIFont(name: NanumFont.bold, size: 20)
        subTitleLabel.font = UIFont(name: NanumFont.bold, size: 13)
        subTitleLabel.numberOfLines = 0
        bodyLabel.font = UIFont(name: NanumFont.regular, size: 13)
        bodyLabel.textColor = UIColor.dark2
        bodyLabel.numberOfLines = 0
        
        let nanum = NanumFont()
        nanum.setLineSpace(label: self.subTitleLabel, space:6)
        nanum.setLineSpace(label: bodyLabel, space: 5)

        divideView.backgroundColor = UIColor.dark2
    }
}
