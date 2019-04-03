//
//  MeasureVC.swift
//  HealthAssistant
//
//  Created by VTS AppsTeam on 3/26/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit
import CoreMotion

class MeasureVC: UIViewController {
    
    @IBOutlet weak var gyroLbl: UILabel!
    @IBOutlet weak var accelerLbl: UILabel!
    
    let motion = CMMotionManager()
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startGyroPressed(_ sender: Any) {
        startGyros()
    }
    @IBAction func stopGyroPressed(_ sender: Any) {
        stopGyros()
    }
    
    func startGyros() {
        if motion.isGyroAvailable {
            if self.motion.isAccelerometerAvailable {
                self.motion.gyroUpdateInterval = 1.0 / 60.0
                self.motion.startGyroUpdates()
                self.motion.accelerometerUpdateInterval = 1.0 / 60.0
                self.motion.startAccelerometerUpdates()
                // Configure a timer to fetch the accelerometer data.
                self.timer = Timer(fire: Date(), interval: 0.1,
                                   repeats: true, block: { (timer) in
                                    // Get the gyro data.
                                    if let data = self.motion.gyroData {
                                        let x = (data.rotationRate.x * 1000).rounded() / 1000
                                        let y = (data.rotationRate.y * 1000).rounded() / 1000
                                        let z = (data.rotationRate.z * 1000).rounded() / 1000
                                        
                                        
                                        
                                        self.gyroLbl.text = "Gyro data: \n \(x) \n \(y) \n \(z)"
                                        
                                        // Use the gyroscope data in your app.
                                    }
                                    if let data = self.motion.accelerometerData {
                                        let x = ((data.acceleration.x * -9.81) * 1000).rounded() / 1000
                                        let y = ((data.acceleration.y * -9.81) * 1000).rounded() / 1000
                                        let z = ((data.acceleration.z * -9.81) * 1000).rounded() / 1000
                                        
                                        self.accelerLbl.text = "Acc data: \n \(x) \n \(y) \n \(z)"
                                        // Use the accelerometer data in your app.
                                    }
                })
                
                // Add the timer to the current run loop.
                RunLoop.current.add(self.timer!, forMode: .default)
            }
        }
    }
    func stopGyros() {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
            
            self.motion.stopGyroUpdates()
        }
    }
}
