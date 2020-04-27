//
//  Extension.swift
//  
//
//  Created by Tasin Zarkoob on 27/04/2020.
//

import UIKit


public extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    func toData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            return Data()
        }
    }
}

