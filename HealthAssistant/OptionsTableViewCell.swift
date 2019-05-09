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

}
