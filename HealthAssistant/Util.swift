//
//  Util.swift
//  HealthAssistant
//
//  Created by VTS AppsTeam on 4/3/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit

class Util {
    static var HAGreen = UIColor(red: 63/255, green: 232/255, blue: 183/255, alpha: 1)
    
    static func displayDialog(_ viewController: UIViewController, title: String, message: String, handler: @escaping () -> ()) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { action in
            alertController.dismiss(animated: true, completion: nil)
            handler()
        }
        
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func displayInformation(_ viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
