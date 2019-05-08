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
    let api = "http://ha.itcentar.rs"
//    let api = "172.16.40.108"
    var user: User?
    
    func register(ime: String, prezime: String, email: String, password: String, completion: @escaping (Bool) -> ()) {
        let parameters = ["name": ime, "lastname": prezime, "email": email, "password": password, "role": "PATIENT"]
        AF.request("\(api)/api/registration", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let status = json["status"]
                    if status.intValue == 200 {
                        let userData = json["entity"]
                        let userName = userData["name"].stringValue
                        let userLastName = userData["lastname"].stringValue
                        let userToken = userData["token"].stringValue
                        let userEmail = userData["email"].stringValue
                        self.user = User(names: userName, lastname: userLastName, Email: userEmail, tokens: userToken, pass: password)
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
    
    func logIn(email: String, password: String, completion: @escaping (Bool) -> ()) {
        let parameters = ["email": email, "password": password]
        AF.request("\(api)/api/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let status = json["status"]
                    if status.intValue == 200 {
                        let userData = json["entity"]
                        let userName = userData["name"].stringValue
                        let userLastName = userData["lastname"].stringValue
                        let userToken = userData["token"].stringValue
                        let userEmail = userData["email"].stringValue
                        self.user = User(names: userName, lastname: userLastName, Email: userEmail, tokens: userToken, pass: password)
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
        let params: [String: Any] = ["user_id": "\(API.instance.user?.name ?? "1")", "source": "ios", "data": sensorData]
        AF.request("\(api)/api/data", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let status = json["status"]
                    print(status)
                case .failure(let err):
                    print(err)
                }
        }
    }
}

