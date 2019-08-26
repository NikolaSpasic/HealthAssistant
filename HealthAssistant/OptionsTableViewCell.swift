//
//  OptionsTableViewCell.swift
//  HealthAssistant
//
//  Created by Slavimir Stosovic on 5/9/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    @IBOutlet weak var optionImageView: UIImageView!
    @IBOutlet weak var optionLbl: UILabel!
    @IBOutlet weak var optionIllustration: UIImageView!
    @IBOutlet weak var optionChecked: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        self.bounds = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: UIScreen.main.bounds.width - 60, height: self.bounds.size.height)
        optionChecked.frame = CGRect(x: self.frame.maxX - optionChecked.bounds.width - 60 - 10, y: optionChecked.frame.origin.y, width: optionChecked.frame.width, height: optionChecked.frame.height)
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 6
        self.layer.shadowPath = shadowPath.cgPath
    }
}
