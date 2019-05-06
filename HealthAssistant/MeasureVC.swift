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
    var gatheredSensorData = [SensorData]()
    var secondsToCount = 60
    var timerToSendData = Timer()
    var isTimerRunning = false
    
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
                                    if let gyroData = self.motion.gyroData {
                                        if let accData = self.motion.accelerometerData {
                                            let gyrox = (gyroData.rotationRate.x * 1000).rounded() / 1000
                                            let gyroy = (gyroData.rotationRate.y * 1000).rounded() / 1000
                                            let gyroz = (gyroData.rotationRate.z * 1000).rounded() / 1000
                                            
                                            let accx = ((accData.acceleration.x * -9.81) * 1000).rounded() / 1000
                                            let accy = ((accData.acceleration.y * -9.81) * 1000).rounded() / 1000
                                            let accz = ((accData.acceleration.z * -9.81) * 1000).rounded() / 1000
                                            
                                            self.accelerLbl.text = "Acc data: \n \(accx) \n \(accy) \n \(accz)"
                                            
                                            self.gyroLbl.text = "Gyro data: \n \(gyrox) \n \(gyroy) \n \(gyroz)"
                                            let singleReading = SensorData(accx: accx, accy: accy, accz: accz, gyx: gyrox, gyy: gyroy, gyz: gyroz)
                                            self.gatheredSensorData.append(singleReading)
                                        }
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
            self.motion.stopAccelerometerUpdates()
        }
    }
}
