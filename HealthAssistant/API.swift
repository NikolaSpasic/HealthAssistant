//
//  API.swift
//  HealthAssistant
//
//  Created by VTS AppsTeam on 4/2/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class API {
    
    static let instance = API()
    let api = "http://miske77.pythonanywhere.com"
    var user: User?
    
    func register(ime: String, prezime: String, email: String, password: String, completion: @escaping (Bool) -> ()) {
        let parameters = ["name": ime, "lastname": prezime, "email": email, "password": password, "role": "PATIENT"]
        AF.request("\(api)/api/registration", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let status = json["status"]
                    print(response.response?.statusCode)
                    if status.intValue == 200 {
                        let userData = json["entity"]
                        print(userData)
                        let userName = userData["name"].stringValue
                        let userLastName = userData["lastname"].stringValue
                        let userToken = userData["token"].stringValue
                        let userEmail = userData["email"].stringValue
                        let userId = userData["id"].stringValue
                        self.user = User(names: userName, lastname: userLastName, Email: userEmail, tokens: userToken, pass: password, id: userId)
                        completion(true)
                    } else {
                        completion(false)
                    }
                case .failure(let err):
                    print("fail")
                    print(err)
                    completion(false)
                }
        }
    }
    
    func logIn(email: String, password: String, completion: @escaping (Bool) -> ()) {
        let parameters = ["email": email, "password": password]
        AF.request("\(api)/api/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    print("gets here \(json)")
                    let status = json["status"]
                    if status.intValue == 200 {
                        let userData = json["entity"]
                        let userName = userData["name"].stringValue
                        let userLastName = userData["lastname"].stringValue
                        let userToken = userData["token"].stringValue
                        let userEmail = userData["email"].stringValue
                        let userId = userData["id"].stringValue
                        self.user = User(names: userName, lastname: userLastName, Email: userEmail, tokens: userToken, pass: password, id: userId)
                        completion(true)
                    } else {
                        completion(false)
                    }
                case .failure(let err):
                    print(err)
                    completion(false)
                }
        }
    }
    
    func sendSensorData(sensorData: [SensorData]) {
        var measurments = [[String:String]]()
        for singleMeasurment in sensorData {
            let measurmentObject = [
                "gx": "\(singleMeasurment.gx!)",
                "gy": "\(singleMeasurment.gy!)",
                "gz": "\(singleMeasurment.gz!)",
                "ax": "\(singleMeasurment.ax!)",
                "ay": "\(singleMeasurment.ay!)",
                "az": "\(singleMeasurment.az!)",
                "timestamp": "\(singleMeasurment.timestamp)"
            ]
            measurments.append(measurmentObject)
        }
        let params: [String: Any] = ["user_id": "\(API.instance.user?.id ?? "1")", "source": "ios", "data": measurments]
        AF.request("\(api)/api/data", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseString { response in
                switch response.result {
                case .success(let data):
                    print("success")
                    print(data)
                case .failure(let failure):
                    print("fail \(failure)")
                }
        }
    }
}

