//
//  ImageLoader.swift
//  BeerApp
//
//  Created by Miguel on 15/02/2022.
//

import UIKit

extension UIImageView {
    
    func imageFromServerURL(_ string: String, placeHolder: UIImage? = nil) {
        
        self.image = nil
        
        let imageServerUrl = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: imageServerUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            guard let wrapped = data, error == nil else {
                
                DispatchQueue.main.async {
                    self.image = placeHolder
                }
                return
            }
            
            DispatchQueue.main.async {
                
                if let downloadedImage = UIImage(data: wrapped) {
                    self.image = downloadedImage
                } else {
                    self.image = placeHolder
                }
            }
            
        }).resume()
    }
}
