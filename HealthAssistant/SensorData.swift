//
//  SensorData.swift
//  HealthAssistant
//
//  Created by Slavimir Stosovic on 5/8/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import Foundation

class SensorData: NSObject, NSCoding {
    let ax: Double?
    let ay: Double?
    let az: Double?
    
    let gx: Double?
    let gy: Double?
    let gz: Double?
    
    var timestamp = ""
    
    init(accx: Double, accy: Double, accz: Double, gyx: Double, gyy: Double, gyz: Double, time: String) {
        ax = accx
        ay = accy
        az = accz
        
        gx = gyx
        gy = gyy
        gz = gyz
        timestamp = time
    }
    required convenience init(coder aDecoder: NSCoder) {
        let ax = aDecoder.decodeDouble(forKey: "ax") 
        let ay = aDecoder.decodeDouble(forKey: "ay")
        let az = aDecoder.decodeDouble(forKey: "az")
        let gx = aDecoder.decodeDouble(forKey: "gx")
        let gy = aDecoder.decodeDouble(forKey: "gy")
        let gz = aDecoder.decodeDouble(forKey: "gz")
        let timestamp = aDecoder.decodeObject(forKey: "timestamp") as! String
        
        self.init(accx: ax, accy: ay, accz: az, gyx: gx, gyy: gy, gyz: gz, time: timestamp)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(ax, forKey: "ax")
        aCoder.encode(ay, forKey: "ay")
        aCoder.encode(az, forKey: "az")
        aCoder.encode(gx, forKey: "gx")
        aCoder.encode(gy, forKey: "gy")
        aCoder.encode(gz, forKey: "gz")
        aCoder.encode(timestamp, forKey: "timestamp")
    }
}
