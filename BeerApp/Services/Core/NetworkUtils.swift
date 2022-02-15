//
//  NetworkUtils.swift
//  BeerApp
//
//  Created by Miguel on 15/02/2022.
//

import UIKit

final class NetworkUtils {
    
    /// Convert NSDictionary to Data
    ///
    /// - Parameter json: the dictionary
    /// - Returns: the data
    static func serializeJson(json: NSDictionary) -> Data? {
        
        do {
            return try JSONSerialization.data(
                withJSONObject: json,
                options: .prettyPrinted)
            
        } catch {
            return nil
        }
    }
    
    /// Convert Data to NSDictionary
    ///
    /// - Parameter data: the data object
    /// - Returns: the dictionary or nil, case fails
    static func desirializeData(data: Data) -> NSDictionary? {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0))
            
            guard let responseJSON = (json as? NSDictionary) else {
                return nil
            }
            
            return responseJSON
        } catch {
            return nil
        }
    }
    
    /// Convert Data to Array of Dictionarys
    ///
    /// - Parameter data: the data object
    /// - Returns: return the array or nil
    static func desirializeDataToArray(data: Data) -> [NSDictionary]? {
        
        do {
            let json = try JSONSerialization.jsonObject(
                with: data,
                options: .init(rawValue: 0))
            
            guard let responseJSON = (json as? [NSDictionary]) else {
                return nil
            }
            
            return responseJSON
            
        } catch {
            return nil
        }
    }
    
    /// Convert data object to a array of strings
    ///
    /// - Parameter data: the data object
    /// - Returns: the array or nil
    static func desirializeDataToStringArray(data: Data) -> [String]? {
        
        do {
            let json = try JSONSerialization.jsonObject(
                with: data,
                options: .init(rawValue: 0))
            
            guard let responseJSON = (json as? [String]) else {
                return nil
            }
            
            return responseJSON
            
        } catch {
            return nil
        }
    }
}
