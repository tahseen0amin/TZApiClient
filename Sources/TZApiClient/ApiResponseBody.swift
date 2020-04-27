//
//  ApiResponseBody.swift
//  
//
//  Created by Tasin Zarkoob on 27/04/2020.
//

import UIKit
import SwiftyJSON

protocol StatusReponse {
    var success: Bool {get}
    var timestamp: TimeInterval {get}
    var message: String? {get}
    var msgCode: Int? {get}
}

protocol DataResponse {
    var payload: JSON {get}
}

/** Class that represents the Response Body Object of the Response */
open class APIResponseBody: StatusReponse, DataResponse, InitializableWithData {
    /** Was API Server able to process your request*/
    var success: Bool = false
    
    /** Timestamp of the response sent by server */
    var timestamp: TimeInterval = 0
    
    /** Message from the server. watch this incase the success is false, the reason will be listed here*/
    var message: String?
    
    /** Optional Message Code */
    var msgCode: Int?
    
    /** Whole response object sent by server and converted into JSON Object */
    var payload: JSON = JSON()
    
    required public init(data: Data?) {
        guard let data = data else {
            self.message = "Empty Data Found"
            return
        }
        do {
            let json = try JSON(data: data)
            self.payload = json
            
            // setup the values
            if let obj = json["success"].bool {
                self.success = obj
            }
            if let obj = json["timestamp"].double {
                self.timestamp = obj
            }
            if let obj = json["message"].string {
                self.message = obj
            }
            if let obj = json["msgCode"].int {
                self.msgCode = obj
            }
            
        }
        catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func convertDataIntoEntity<T: Codable>(data: Data) throws -> T {
       return try GenericDecoder<T>(data: data).decodeEntity()
    }
}


/** Decodes the Data object to the class/struct */
public struct GenericDecoder<T: Codable> {
    let data: Data
    var entity : T? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            debugPrint(error)
            return nil
        }
    }
    
    func decodeEntity() throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
