//
//  APIError.swift
//  Networking
//
//  Created by hyeonjeong on 2020/03/13.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

enum APIError: Error {
    case parsing
    case retryAfter
    case server
    case unknown
}
