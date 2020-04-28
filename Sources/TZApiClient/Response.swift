//
//  Response.swift
//  
//
//  Created by Tasin Zarkoob on 27/04/2020.
//

import UIKit

public protocol InitializableWithData {
    init(data: Data?) throws
}

/** This wraps a successful API response and it includes the generic data as well. The reason why we need this wrapper is that we want to pass to the client the status code and the raw response as well
 */
public struct Response<T: InitializableWithData> {
    public let entity: T
    public let httpUrlResponse: HTTPURLResponse
    public let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        do {
            self.entity = try T(data: data)
            self.httpUrlResponse = httpUrlResponse
            self.data = data
        } catch {
            throw APIParseError(error: error, httpUrlResponse: httpUrlResponse, data: data)
        }
    }
}

/** Some endpoints might return a 204 No Content. We can't have Void implement InitializableWithData so we've created a "Void" response.
*/
public struct VoidResponse: InitializableWithData {
    public init(data: Data?) throws {}
}


