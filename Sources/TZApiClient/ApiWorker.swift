//
//  ApiWorker.swift
//  
//
//  Created by Tasin Zarkoob on 27/04/2020.
//

import Foundation

open class ApiWorker {
    public let client: TZApiClient
    
    public init(client: TZApiClient?) {
        if let c = client {
            self.client = c
        } else {
            self.client = TZApiClient(urlSessionConfiguration: .default, completionHandlerQueue: .main)
        }
    }
    
    public init() {
        self.client = TZApiClient(urlSessionConfiguration: .default, completionHandlerQueue: .main)
    }
}
