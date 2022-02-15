//
//  Structs.swift
//  BeerApp
//
//  Created by Miguel on 15/02/2022.
//

import UIKit

struct BeerObject: Decodable {
    
    var name: String?
    var tagline: String?
    var first_brewed: String?
    var description: String?
    var image_url: String?
    var brewers_tips: String?
    var contributed_by: String?
}
