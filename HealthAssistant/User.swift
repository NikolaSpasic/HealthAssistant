//
//  User.swift
//  HealthAssistant
//
//  Created by VTS AppsTeam on 4/3/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import Foundation

class User {
    var name: String?
    var lastName: String?
    var email: String?
    var password: String?
    var token: String?
    
    init(names: String, lastname: String, Email: String, tokens: String, pass: String) {
        name = names
        lastName = lastname
        email = Email
        token = tokens
        password = pass
        
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(password, forKey: "pass")
        defaults.set(token, forKey: "token")
        defaults.set(name, forKey: "name")
        defaults.set(lastName, forKey: "lastname")
    }
    init(named: String, lastname: String, Email: String, tokens: String, pass: String) {
        name = named
        lastName = lastname
        email = Email
        token = tokens
        password = pass
    }
}
