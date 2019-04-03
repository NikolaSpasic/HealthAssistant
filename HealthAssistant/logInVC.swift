//
//  logInVC.swift
//  HealthAssistant
//
//  Created by VTS AppsTeam on 3/26/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit

class logInVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var logInBttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self
        self.passTextField.delegate = self
        
        emailTextField.textColor = UIColor.white
        passTextField.textColor = UIColor.white
        logInBttn.layer.cornerRadius = 15
        topConstraint.constant = UIScreen.main.bounds.height * 0.1
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func logInBttnPressed(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let pass = passTextField.text ?? ""
        if !email.isEmpty && !pass.isEmpty {
            var overlay = UIView()
            overlay = Spinner.makeOverlay(over: self)
            self.view.isUserInteractionEnabled = false
            API.instance.logIn(email: email, password: pass, completion: { result in
                if result == true {
                    self.emailTextField.text = ""
                    self.passTextField.text = ""
                    self.view.isUserInteractionEnabled = true
                    overlay.removeFromSuperview()
                    self.performSegue(withIdentifier: "showHomeLogIn", sender: nil)
                } else {
                    self.view.isUserInteractionEnabled = true
                    overlay.removeFromSuperview()
                    Util.displayInformation(self, title: "Nesto nije u redu.", message: "Pokusajte ponovo.")
                }
            })
        } else {
            Util.displayInformation(self, title: "Neko polje je prazno.", message: "Popunite sva polja i pokusajte ponovo.")
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                if UIScreen.main.nativeBounds.height == 1136 {
                    self.view.frame.origin.y -= UIScreen.main.bounds.height * 0.1 + 40
                } else {
                    self.view.frame.origin.y -= UIScreen.main.bounds.height * 0.15
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}
