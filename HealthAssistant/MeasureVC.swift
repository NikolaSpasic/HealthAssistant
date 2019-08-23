//
//  MeasureVC.swift
//  HealthAssistant
//
//  Created by VTS AppsTeam on 3/26/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit
import CoreMotion
import Reachability

class MeasureVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var gyroLbl: UILabel!
    @IBOutlet weak var accelerLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var startMeasuringBttn: UIButton!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var measureStatusLbl: UILabel!
    
    let motion = CMMotionManager()
    var timer: Timer!
    var gatheredSensorData = [SensorData]()
    var timeLeft = 15
    var dataTimer: Timer?
    var isTimerRunning = false
    var collectingData = false
    var measurementOptions = [MeasurmentOption]()
    var brokenImg: UIImage!
    var selectedMeasurmentOptions = [String]()
    var measureStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brokenImg = UIColor.black.image()
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        optionsTableView.rowHeight = 90
        optionsTableView.tableFooterView = UIView()
        measurementOptions.append(MeasurmentOption(logoimg: UIImage(named: "activity_icon") ?? brokenImg, illustrationImg: UIImage(named: "activity_lines") ?? brokenImg, activityName: "Aktivnost"))
    }
    
    override func viewDidLayoutSubviews() {
        startMeasuringBttn.layer.cornerRadius = startMeasuringBttn.frame.width / 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return measurementOptions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionsCell", for: indexPath) as! OptionsTableViewCell
        cell.optionImageView.image = measurementOptions[indexPath.section].logo
        cell.optionLbl.text = measurementOptions[indexPath.section].name
        cell.optionIllustration.image = measurementOptions[indexPath.section].illustration
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1.0).cgColor
        cell.layer.cornerRadius = 7
        cell.optionChecked.image = cell.optionChecked.image?.withRenderingMode(.alwaysTemplate)
        cell.optionChecked.tintColor = Util.HAGreen
        if !selectedMeasurmentOptions.contains(measurementOptions[indexPath.row].name) {
            cell.optionChecked.isHidden = true
        } else {
            cell.optionChecked.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        optionsTableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? OptionsTableViewCell {
            if !selectedMeasurmentOptions.contains(measurementOptions[indexPath.section].name) {
                selectedMeasurmentOptions.append(measurementOptions[indexPath.section].name)
                cell.optionChecked.isHidden = false
            } else {
                selectedMeasurmentOptions.removeAll { $0 == measurementOptions[indexPath.section].name }
                cell.optionChecked.isHidden = true
            }
        }
    }
    
    @IBAction func startGyroPressed(_ sender: Any) {
        if measureStarted {
            startMeasuringBttn.setImage(#imageLiteral(resourceName: "start_btn_icon"), for: .normal)
            UIView.animate(withDuration: 0.3, animations: {
                self.backgroundColorView.backgroundColor = UIColor(red: 55/255, green: 229/255, blue: 174/255, alpha: 1.0)
            })
            measureStatusLbl.text = "Pokrenite merenje"
            stopGyros()
            measureStarted = false
        } else {
            if selectedMeasurmentOptions.contains("Aktivnost") {
                if collectingData == false {
                    dataTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateDataTimer), userInfo: nil, repeats: true)
                    startGyros()
                    startMeasuringBttn.setImage(#imageLiteral(resourceName: "stop_btn_icon"), for: .normal)
                    UIView.animate(withDuration: 0.3, animations: {
                        self.backgroundColorView.backgroundColor = UIColor(red: 225/255, green: 104/255, blue: 104/255, alpha: 1.0)
                    })
                    measureStatusLbl.text = "Zaustavite merenje"
                    collectingData = true
                    measureStarted = true
                }
            } else {
                Util.displayInformation(self, title: "Niste izabrali opcije za merenje", message: "Izaberite opcije i pokusajte ponovo.")
            }
        }
    }
    @IBAction func stopGyroPressed(_ sender: Any) {
        stopGyros()
    }
    
    @objc func updateDataTimer() {
        timeLeft -= 1
        timerLbl.text = "\(timeLeft) seconds until data is sent"
        if timeLeft <= 0 {
            if !gatheredSensorData.isEmpty {
//                let isConnectedToWifi = check()
//                if isConnectedToWifi {
                    API.instance.sendSensorData(sensorData: gatheredSensorData)
//                } else {
//                    Util.displayDialog(self, title: "Your phone isn't connected to wifi.", message: "Do you want to send data to server anyway?") {
//                        API.instance.sendSensorData(sensorData: self.gatheredSensorData)
//                    }
//                }
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
            collectingData = false
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
//            let isConnectedToWifi = check()
//            if isConnectedToWifi {
                API.instance.sendSensorData(sensorData: gatheredSensorData)
                gatheredSensorData.removeAll()
//            } else {
//                Util.displayDialog(self, title: "Your phone isn't connected to wifi.", message: "Do you want to send data to server anyway?") {
//                    API.instance.sendSensorData(sensorData: self.gatheredSensorData)
//                    self.gatheredSensorData.removeAll()
//                }
//            }
        }
        dataTimer?.invalidate()
        dataTimer = nil
        timeLeft = 15
        collectingData = false
    }
    
    func check() -> Bool {
        let reachability = Reachability()!
        var connected: Bool = false
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                connected = true
            }
        }
        return connected
    }
}
