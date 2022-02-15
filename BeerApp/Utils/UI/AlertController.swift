//
//  AlertController.swift
//  BeerApp
//
//  Created by Miguel on 15/02/2022.
//

import UIKit

protocol AlertController {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction])
}

extension AlertController where Self: UIViewController {
    
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]? = nil) {
        
        guard presentedViewController == nil else {
            return
        }
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        actions?.forEach { action in
            alertController.addAction(action)
        }
        
        present(alertController, animated: true)
    }
}
