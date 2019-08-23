//
//  ActivitiesCollectionViewCell.swift
//  HealthAssistant
//
//  Created by Slavimir Stosovic on 8/23/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit

class ActivitiesCollectionViewCell: UICollectionViewCell {
    override func layoutSubviews() {
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 6
        self.layer.shadowPath = shadowPath.cgPath
    }
}
