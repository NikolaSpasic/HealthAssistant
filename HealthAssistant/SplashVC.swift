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
        if email != nil && pass != nil && token != nil && lastname != nil && name != nil {
            let user = User(named: name!, lastname: lastname!, Email: email!, tokens: token!, pass: pass!)
            API.instance.user = user
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "homeVC")
            self.present(newViewController, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "showLogIn", sender: nil)
        }
    }

}

