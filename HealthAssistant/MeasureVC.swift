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
    @IBOutlet weak var timerLbl: UILabel!
    
    let motion = CMMotionManager()
    var timer: Timer!
    var gatheredSensorData = [SensorData]()
    var timeLeft = 15
    var dataTimer: Timer?
    var isTimerRunning = false
    var collectingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startGyroPressed(_ sender: Any) {
        if collectingData == false {
            dataTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateDataTimer), userInfo: nil, repeats: true)
            startGyros()
            collectingData = true
        }
    }
    @IBAction func stopGyroPressed(_ sender: Any) {
        stopGyros()
        collectingData = false
    }
    
    @objc func updateDataTimer() {
        timeLeft -= 1
        timerLbl.text = "\(timeLeft) seconds until data is sent"
        if timeLeft <= 0 {
            if !gatheredSensorData.isEmpty {
                API.instance.sendSensorData(sensorData: gatheredSensorData)
            }
            timeLeft = 15
        }
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
            } else {
                Util.displayInformation(self, title: "Accelerometer is not working", message: "Can't measure data.")
                stopGyros()
            }
        } else {
            Util.displayInformation(self, title: "Gyroscope is not working", message: "Can't measure data.")
            dataTimer?.invalidate()
            dataTimer = nil
            timeLeft = 15
        }
    }
    func stopGyros() {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
            
            self.motion.stopGyroUpdates()
            self.motion.stopAccelerometerUpdates()
        }
        if !gatheredSensorData.isEmpty {
            API.instance.sendSensorData(sensorData: gatheredSensorData)
            gatheredSensorData.removeAll()
        }
        dataTimer?.invalidate()
        dataTimer = nil
        timeLeft = 15
    }
}
