//
//  Request.swift
//  
//
//  Created by Tasin Zarkoob on 27/04/2020.
//

import UIKit

public protocol APIRequest {
    var urlRequest: URLRequest { get }
}

public struct Endpoint {
    public var path: String
    public var queryItems: [URLQueryItem] = []
}

public extension APIRequest {
    /** Returns the URLRequest Object from the String */
    func initBaseRequest(withURLString string: String) -> URLRequest {
        guard let url = URL(string: string) else {
            fatalError()
        }
        return getRequest(with: url)
    }
    
    /** Returns the URLRequest from the URL*/
    func initBaseRequest(withURL url: URL) -> URLRequest {
        return getRequest(with: url)
    }

    private func getRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 40
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        // set the auth token if any
        if let token = UserDefaults.standard.object(forKey: "API_AUTH_TOKEN_KEY") as? String {
            let authToken = "Bearer " + token
            request.setValue(authToken, forHTTPHeaderField: "Authorization")
        }
        return request
    }
}

public protocol Params : Codable {}
public extension Params {
    /** Converts into Data */
    func toData() -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch {}
        return nil
    }
}

public protocol ParamType {}
extension String : ParamType {}
extension Int : ParamType {}
extension Bool : ParamType {}
