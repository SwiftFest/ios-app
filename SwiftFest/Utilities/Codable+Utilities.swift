//
//  Codable+Utilities.swift
//  SwiftFest
//
//  Created by Zev Eisenberg on 6/9/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import Foundation

extension JSONDecoder {

    static var `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

}
