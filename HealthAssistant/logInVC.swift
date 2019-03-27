//
//  logInVC.swift
//  HealthAssistant
//
//  Created by VTS AppsTeam on 3/26/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit

class logInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInBttnPressed(_ sender: Any) {
        performSegue(withIdentifier: "showMeasure", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
