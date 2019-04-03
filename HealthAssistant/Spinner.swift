//
//  Spinner.swift
//  HealthAssistant
//
//  Created by VTS AppsTeam on 4/3/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit

class Spinner {
    class func makeOverlay(over viewController: UIViewController, uiEnabled: Bool = true) -> UIView {
        if !uiEnabled {
            viewController.view.isUserInteractionEnabled = false
            viewController.navigationController?.view.isUserInteractionEnabled = false
        }
        
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let backgroundView = UIView()
        backgroundView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        backgroundView.addSubview(indicator)
        
        backgroundView.center = viewController.view.center
        backgroundView.layer.cornerRadius = 10
        
        let overlay = UIView()
        overlay.frame = UIScreen.main.bounds
        overlay.backgroundColor = UIColor.clear
        
        overlay.addSubview(backgroundView)
        overlay.center = viewController.view.window!.center
        overlay.center.y += UIScreen.main.bounds.height * 0.06 + 30
        
        viewController.view.window!.addSubview(overlay)
        
        UIView.transition(with: viewController.view.window!, duration: 0.25, options: .transitionCrossDissolve, animations: {
            viewController.view.window!.addSubview(overlay)
        }, completion: nil)
        
        indicator.startAnimating()
        
        return overlay
    }
}
