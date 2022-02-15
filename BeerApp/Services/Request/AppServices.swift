//
//  AppServices.swift
//  BeerApp
//
//  Created by Miguel on 15/02/2022.
//

import UIKit

final class AppServices {
    
    /// Get the beers list
    /// - Parameter callback: the callback
    public static func getBeers(callback: @escaping RequestCallback<[BeerObject]>) {
        
        guard let request = NetworkRequest.init(
            endPoint: RequestEndpoints.getBeers,
            method: .GET) else {
                
                callback(nil)
                return
            }
        
        request.send { data in
            
            do {
                
                let cenas = NetworkUtils.desirializeDataToArray(data: data)
                
                let items = try JSONDecoder().decode([BeerObject].self, from: data)
                callback(items)
                
            } catch let error {
                
                Log.e(error.localizedDescription)
                callback(nil)
            }
            
        } failure: { message in
            
            Log.e(message ?? "--")
            callback(nil)
        }
    }
}
