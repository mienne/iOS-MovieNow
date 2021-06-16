//
//  Videos.swift
//  MovieNow
//
//  Created by hyeonjeong on 2020/03/28.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

struct Videos: Codable {
    let id: Int?
    let results: [Video]?
}

struct Video: Codable {
    let id: String?
    let key: String?
    let name: String?
}
