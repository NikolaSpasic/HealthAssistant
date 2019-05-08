//
//  SensorData.swift
//  HealthAssistant
//
//  Created by Slavimir Stosovic on 5/8/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import Foundation

class SensorData {
    let ax: Double?
    let ay: Double?
    let az: Double?
    
    let gx: Double?
    let gy: Double?
    let gz: Double?
    
    let timestamp = ""
    
    init(accx: Double, accy: Double, accz: Double, gyx: Double, gyy: Double, gyz: Double) {
        ax = accx
        ay = accy
        az = accz
        
        gx = gyx
        gy = gyy
        gz = gyz
    }
}
