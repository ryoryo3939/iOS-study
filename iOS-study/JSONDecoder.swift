//
//  JSONDecoder+Extensions.swift
//  iOS-study
//
//  Created by S892 on 2023/07/07.
//

import Foundation

extension JSONDecoder {
    static var customDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
