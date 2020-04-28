//
//  Errors.swift
//  
//
//  Created by Tasin Zarkoob on 27/04/2020.
//

import UIKit

/** Can be thrown by InitializableWithData.init(data: Data?) implementations when parsing the data
*/
public struct APIParseError: Error {
    public static let code = 999
    
    public let error: Error
    public let httpUrlResponse: HTTPURLResponse
    public let data: Data?
    
    public var localizedDescription: String {
        return error.localizedDescription
    }
}

/** Can be thrown when we can't even reach the API */
public struct NetworkRequestError: Error {
    public let error: Error?
    public var localizedDescription: String {
        return error?.localizedDescription ?? "Network request error - no other information"
    }
}

/** Can be thrown when we reach the API but the it returns a 4xx or a 5xx */
public struct APIError: Error {
    public let data: Data?
    public let httpUrlResponse: HTTPURLResponse
}

public extension NSError {
    static func createPraseError() -> NSError {
        return NSError(domain: "apps.taseen.tzapiclient",
                       code: APIParseError.code,
                       userInfo: [NSLocalizedDescriptionKey: "A parsing error occured"])
    }
}
