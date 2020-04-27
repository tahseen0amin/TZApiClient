//
//  Errors.swift
//  
//
//  Created by Tasin Zarkoob on 27/04/2020.
//

import UIKit

/** Can be thrown by InitializableWithData.init(data: Data?) implementations when parsing the data
*/
struct APIParseError: Error {
    static let code = 999
    
    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    var localizedDescription: String {
        return error.localizedDescription
    }
}

/** Can be thrown when we can't even reach the API */
struct NetworkRequestError: Error {
    let error: Error?
    var localizedDescription: String {
        return error?.localizedDescription ?? "Network request error - no other information"
    }
}

/** Can be thrown when we reach the API but the it returns a 4xx or a 5xx */
struct APIError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}

extension NSError {
    static func createPraseError() -> NSError {
        return NSError(domain: "apps.taseen.tzapiclient",
                       code: APIParseError.code,
                       userInfo: [NSLocalizedDescriptionKey: "A parsing error occured"])
    }
}
