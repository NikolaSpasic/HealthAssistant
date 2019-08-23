//
//  resultsTableviewCell.swift
//  HealthAssistant
//
//  Created by Slavimir Stosovic on 8/23/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit

class resultsTableviewCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var activityNameLbl: UILabel!
    @IBOutlet weak var lineImageView: UIImageView!
    @IBOutlet weak var measurementValueLbl: UILabel!
    
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
        measurementValueLbl.frame = CGRect(x: self.frame.maxX - measurementValueLbl.bounds.width - 60 - 15, y: measurementValueLbl.frame.origin.y, width: measurementValueLbl.frame.width, height: measurementValueLbl.frame.height)
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 6
        self.layer.shadowPath = shadowPath.cgPath
    }

}
