//
//  NetworkConfiguration.swift
//  BeerApp
//
//  Created by Miguel on 15/02/2022.
//

import UIKit

// General callbacks
typealias FailureBlock = (_ message: String?) -> Void
typealias SuccessBlock = (_ data: Data) -> Void

// Abstract callback
typealias RequestCallback<T> = (_ object: T?) -> Void

// Http Methods
public enum HttpMethod: String {
    case GET, POST, PUT, DELETE
}

// Configuration for request
struct RequestValues {
    
    static let timeOut: TimeInterval = 25.0
    static let authorizationHeader = "Authorization"
    static let contentTypeHeader = "Content-Type"
    static let contentTypeJsonValue = "application/json"
    static let contentTypeWwwForm = "application/x-www-form-urlencoded"
    
    static let apiKeyValue = "bcd33a8d51e5f7e022c3c44f7e1d04e3"
}

// Server Endpoints
struct RequestEndpoints {
    
    // Private values for the endpoints
    private static let endPoint = "https://api.punkapi.com/v2/beers"
    
    // Public endpoint for the requests
    static let getBeers = endPoint
}

