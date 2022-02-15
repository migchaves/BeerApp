//
//  BaseController.swift
//  BeerApp
//
//  Created by Miguel on 15/02/2022.
//

import UIKit

class BaseController: UIViewController {

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initElements()
    }
    
    func initElements() {
        
    }
    
    // MARK: - Show and remove loader

    func showLoader() {
        Loader.shared.show()
    }
    
    func hideLoader() {
        Loader.shared.hide()
    }
}
