//
//  RegisterVC.swift
//  HealthAssistant
//
//  Created by VTS AppsTeam on 4/2/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var registerBttn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passTextField.delegate = self
        
        nameTextField.textColor = UIColor.white
        lastNameTextField.textColor = UIColor.white
        emailTextField.textColor = UIColor.white
        passTextField.textColor = UIColor.white
        topConstraint.constant = UIScreen.main.bounds.height * 0.1
        registerBttn.layer.cornerRadius = 15
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func registerBttnPressed(_ sender: Any) {
        
        let ime = nameTextField.text ?? ""
        let prezime = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let pass = passTextField.text ?? ""
        if !ime.isEmpty && !email.isEmpty && !prezime.isEmpty && !pass.isEmpty {
            var overlay = UIView()
            overlay = Spinner.makeOverlay(over: self, uiEnabled: false)
            self.view.isUserInteractionEnabled = false
            API.instance.register(ime: ime, prezime: prezime, email: email, password: pass, completion: { result in
                if result == true {
                    self.nameTextField.text = ""
                    self.emailTextField.text = ""
                    self.passTextField.text = ""
                    self.lastNameTextField.text = ""
                    self.view.isUserInteractionEnabled = true
                    overlay.removeFromSuperview()
                    self.performSegue(withIdentifier: "showHomeRegister", sender: nil)
                } else {
                    //show dialog
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
                    self.view.frame.origin.y -= UIScreen.main.bounds.height * 0.1 + 60
                } else {
                    self.view.frame.origin.y -= UIScreen.main.bounds.height * 0.1
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
