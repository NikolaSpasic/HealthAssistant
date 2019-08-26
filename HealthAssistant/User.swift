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
    var id: String?
    
    init(names: String, lastname: String, Email: String, tokens: String, pass: String, id: String) {
        name = names
        lastName = lastname
        email = Email
        token = tokens
        password = pass
        self.id = id
        
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(password, forKey: "pass")
        defaults.set(token, forKey: "token")
        defaults.set(name, forKey: "name")
        defaults.set(lastName, forKey: "lastname")
        defaults.set(self.id, forKey: "id")
    }
    init(named: String, lastname: String, Email: String, tokens: String, pass: String, ids: String) {
        name = named
        lastName = lastname
        email = Email
        token = tokens
        password = pass
        id = ids
    }
}
