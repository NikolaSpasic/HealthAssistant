//
//  MeasurementOption.swift
//  HealthAssistant
//
//  Created by Slavimir Stosovic on 5/9/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import Foundation
import UIKit

class MeasurmentOption {
    let logo: UIImage
    let illustration: UIImage
    let name: String
    
    init(logoimg: UIImage, illustrationImg: UIImage, activityName: String) {
        logo = logoimg
        illustration = illustrationImg
        name = activityName
    }
}
