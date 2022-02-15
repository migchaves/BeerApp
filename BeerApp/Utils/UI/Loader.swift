//
//  Loader.swift
//  BeerApp
//
//  Created by Miguel on 15/02/2022.
//

import UIKit

public class Loader {
    
    public static let shared = Loader()
    private var blurImg = UIImageView()
    private var indicator = UIActivityIndicatorView()
    
    private init() {
        self.blurImg.frame = UIScreen.main.bounds
        self.blurImg.backgroundColor = UIColor.black
        self.blurImg.isUserInteractionEnabled = true
        self.blurImg.alpha = 0.5
        self.indicator.style = UIActivityIndicatorView.Style.large
        self.indicator.center = self.blurImg.center
        self.indicator.startAnimating()
        self.indicator.color = .red
    }
    
    /// Show the loading
    func show() {
        
        DispatchQueue.main.async( execute: {
            
            guard let window = (UIApplication
                    .shared
                    .connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }) else {
                        return
                    }
            
            window.addSubview(self.blurImg)
            window.addSubview(self.indicator)
        })
    }
    
    /// Hide the loading
    func hide() {
        
        DispatchQueue.main.async(execute: {
            self.blurImg.removeFromSuperview()
            self.indicator.removeFromSuperview()
        })
    }
    
}
