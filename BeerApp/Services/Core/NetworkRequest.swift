//
//  NetworkRequest.swift
//  BeerApp
//
//  Created by Miguel on 15/02/2022.
//

import UIKit

final class NetworkRequest {
    
    // MARK: - Variables
    
    private var request: URLRequest?
    private var task: URLSessionDataTask?
    
    // MARK: - Init
    
    /// Init a NetworkRequest object with the given configuration. Returns nil if fails
    ///
    /// - Parameters:
    ///   - endPoint: the endpoint
    ///   - method: the http method (GET, POST, etc)
    ///   - json: the json object (optional)
    convenience init?(endPoint: String, method: HttpMethod, json: NSDictionary? = nil) {
        
        self.init()
        
        let error = self.configureRequest(
            endPoint: endPoint,
            method: method,
            json: json)
        
        if let wrapped = error {
            Log.e(wrapped)
            return nil
        }
    }
    
    // MARK: - Send and Cancel request
    
    /// Send the request to the given endpoint
    ///
    /// - Parameters:
    ///   - success: the success callback
    ///   - failure: the failure callback
    func send(success: @escaping SuccessBlock, failure: @escaping FailureBlock) {
        
        guard self.request != nil else {
            DispatchQueue.main.async {
                failure(nil)
            }
            return
        }
        
        self.task = URLSession.shared.dataTask(with: self.request!, completionHandler: { (data, response, error) in
            
            // Check for response
            guard let httpResponse = response as? HTTPURLResponse else {
                Log.e("Error obtaing httpResponse")
                DispatchQueue.main.async {
                    failure(nil)
                }
                return
            }
            
            // Ensure the server responds with status code 200
            guard httpResponse.statusCode == 200 else {
                
                Log.e("Status code is not 200")
                
                if error != nil {
                    DispatchQueue.main.async {
                        failure(error!.localizedDescription)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    failure("Status code: \(httpResponse.statusCode)")
                }
                
                return
            }
            
            guard data != nil else {
                
                Log.e("Data is nil")
                
                DispatchQueue.main.async {
                    failure("No data")
                }
                return
            }
            
            DispatchQueue.main.async {
                success(data!)
            }
        })
        
        self.task?.resume()
    }
    
    /// Cancel the current request
    func cancel() {
        Log.i("Canceling request")
        self.task?.cancel()
    }
    
    // MARK: - Configure Request
    
    /// Private func to configure the request
    ///
    /// - Parameters:
    ///   - endPoint: the endpoint
    ///   - method: the http method
    ///   - json: the json object
    private func configureRequest(
        endPoint: String,
        method: HttpMethod,
        json: NSDictionary?) -> String? {
            
            guard let url = URL(string: endPoint) else {
                Log.e("Error creating URL for \(endPoint)")
                return "Error creating URL for \(endPoint)"
            }
            
            self.request = URLRequest(
                url: url,
                cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                timeoutInterval: RequestValues.timeOut)
            
            guard self.request != nil else {
                return "Error creating request"
            }
            
            self.request!.httpMethod = method.rawValue
            
            if (method == .POST || method == .PUT) {
                self.request!.addValue(
                    RequestValues.contentTypeJsonValue,
                    forHTTPHeaderField: RequestValues.contentTypeHeader)
            }
            
            if let wrappedJson = json {
                if let data = NetworkUtils.serializeJson(json: wrappedJson) {
                    self.request!.httpBody = data
                }
            }
            
            return nil
        }
}
