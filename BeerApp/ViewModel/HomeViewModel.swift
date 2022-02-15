//
//  HomeViewModel.swift
//  BeerApp
//
//  Created by Miguel on 15/02/2022.
//

import UIKit

final class HomeViewModel {
    
    // MARK: - Variables
    
    var dataLoaded: (([BeerObject]?) -> Void)?
    var itemsList: [BeerObject]?
    
    // MARK: - Get data
    
    /// Get the data from the API
    public func getData() {
        
        AppServices.getBeers { [weak self] items in
            
            guard let self = self else {
                return
            }
            
            guard let wrapped = items, let callback = self.dataLoaded else {
                return
            }
            
            self.itemsList = wrapped
            callback(wrapped)
        }
    }
    
    // MARK: - Aux
    
    /// Number of items in list
    /// - Returns: the number of items
    func numberOrRows() -> Int {
        return self.itemsList?.count ?? 0
    }
    
    /// Get the beer object for the given index
    /// - Parameter index: the index
    /// - Returns: the beer, if exists
    func getBeer(index: Int) -> BeerObject? {
        return self.itemsList?[index]
    }
}
