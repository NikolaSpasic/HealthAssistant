//
//  LogInRegisterVC.swift
//  HealthAssistant
//
//  Created by VTS AppsTeam on 3/26/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit

class LogInRegisterVC: UIViewController {
    
    @IBOutlet weak var logInView: UIView!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var segmentedCtrl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedCtrl.selectedSegmentIndex = 0
        segmentedCtrlPressed(segmentedCtrl)
    }
    
    @IBAction func segmentedCtrlPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.logInView.alpha = 1
                self.registerView.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.logInView.alpha = 0
                self.registerView.alpha = 1
            })
        }
    }
}
