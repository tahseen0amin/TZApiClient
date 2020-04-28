//
//  TZApiClient.swift
//  
//
//  Created by Tasin Zarkoob on 27/04/2020.
//

import Foundation
import UIKit

public struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
    init(path: String){
        self.path = path
    }
}

open class TZApiClient: NSObject, APIClientImplementation {
    public var urlSession: URLSessionProtocol
    
    public init(urlSessionConfiguration: URLSessionConfiguration, completionHandlerQueue: OperationQueue) {
        urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: completionHandlerQueue)
        super.init()
        urlSession = URLSession(configuration: urlSessionConfiguration, delegate: self, delegateQueue: completionHandlerQueue)
    }
    
    // This should be used mainly for testing purposes
    public init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    public func execute<T>(request: APIRequest, completionHandler: @escaping (Result<Response<T>>) -> Void) where T : InitializableWithData
    {
        debugPrint(request.urlRequest.url!)
        let dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                if let err = error as NSError? {
                    if err.code == -1003 {
                        debugPrint("Check if VPN is connected or not")
                    }
                }
                completionHandler(.failure(NetworkRequestError(error: error)))
                return
            }
            
            let successRange = 200...299
            if successRange.contains(httpUrlResponse.statusCode) {
                do {
                    let response = try Response<T>(data: data, httpUrlResponse: httpUrlResponse)
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(error))
                }
            } else {
                completionHandler(.failure(APIError(data: data, httpUrlResponse: httpUrlResponse)))
            }
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        dataTask.resume()
    }
}

extension TZApiClient: URLSessionDelegate {
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        
    }
}

public typealias Handler = (Data?, URLResponse?, Error?) -> Void

public protocol APIClientImplementation {
    func execute<T>(request: APIRequest, completionHandler: @escaping (_ result: Result<Response<T>>) -> Void)
}

public protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping Handler) -> URLSessionDataTask
}
extension URLSession: URLSessionProtocol { }

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}


