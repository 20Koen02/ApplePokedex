//
//  RequestError.swift
//  ApplePokedex
//
//  Created by Koen van Wijngaarden on 12/10/2022.
//

import Foundation

enum RequestError: Error {
    case urlError(URLError)
    case decodingError(DecodingError)
    case genericError(Error)
}
