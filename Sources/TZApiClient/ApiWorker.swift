//
//  ApiWorker.swift
//  
//
//  Created by Tasin Zarkoob on 27/04/2020.
//

import Foundation

open class ApiWorker {
    let client: TZApiClient
    
    init(client: TZApiClient?) {
        if let c = client {
            self.client = c
        } else {
            self.client = TZApiClient(urlSessionConfiguration: .default, completionHandlerQueue: .main)
        }
    }
    
    init() {
        self.client = TZApiClient(urlSessionConfiguration: .default, completionHandlerQueue: .main)
    }
}
