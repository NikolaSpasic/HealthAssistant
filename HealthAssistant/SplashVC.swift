//
//  ViewController.swift
//  HealthAssistant
//
//  Created by VTS AppsTeam on 3/26/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        sleep(1)
        let defaults = UserDefaults.standard
        let email = defaults.object(forKey: "email") as? String
        let pass = defaults.object(forKey: "pass") as? String
        let token = defaults.object(forKey: "token") as? String
        let lastname = defaults.object(forKey: "lastname") as? String
        let name = defaults.object(forKey: "name") as? String
        let id = defaults.object(forKey: "id") as? String
        if email != nil && pass != nil && token != nil && lastname != nil && name != nil && id != nil {
            let user = User(named: name!, lastname: lastname!, Email: email!, tokens: token!, pass: pass!, ids: id!)
            API.instance.user = user
            unarchiveData()
            uncarchiveActivities()
            if !API.instance.temporarySensorData.isEmpty {
                API.instance.sendSensorData(sensorData: API.instance.temporarySensorData)
            }
            performSegue(withIdentifier: "presentHomeVC", sender: nil)
        } else {
            performSegue(withIdentifier: "showLogIn", sender: nil)
        }
    }
    
    func uncarchiveActivities() {
        let userDefaults = UserDefaults.standard
        let decoded = userDefaults.data(forKey: "activities")
        do {
            if let decodedExists = decoded {
                if let decodedActivities = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedExists) as? [Activity] {
                    API.instance.activities = decodedActivities
                }
            }
        } catch {
            print("couldn't decode activities")
        }
    }
    
    func unarchiveData() {
        let userDefaults = UserDefaults.standard
        let decoded = userDefaults.data(forKey: "failedMeasureData")
        do {
            if let decodedExists = decoded {
                if let decodedMeasurments = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decodedExists) as? [SensorData] {
                    API.instance.temporarySensorData = decodedMeasurments
                }
            }
        } catch {
            print("couldn't read file")
        }
    }

}

