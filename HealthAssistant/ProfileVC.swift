//
//  ProfileVC.swift
//  HealthAssistant
//
//  Created by VTS AppsTeam on 4/3/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var logOutBttn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = API.instance.user {
            if user.name != nil && user.lastName != nil {
                userNameLbl.text = "\(user.name!) \(user.lastName!)"
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        logOutBttn.layer.cornerRadius = 7
    }
    

    @IBAction func logOutBttnPressed(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "pass")
        defaults.removeObject(forKey: "token")
        defaults.removeObject(forKey: "name")
        defaults.removeObject(forKey: "lastname")
        defaults.removeObject(forKey: "activities")
        defaults.synchronize()
        self.dismiss(animated: true, completion: nil)
    }

}
