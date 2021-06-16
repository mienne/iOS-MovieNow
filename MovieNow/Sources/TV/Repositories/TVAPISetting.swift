//
//  TVAPISetting.swift
//  MovieNow
//
//  Created by hyeonjeong on 2020/03/13.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

enum TVAPISetting: APISetting {
    case trending(page: Int)
    case onAir(page: Int)
    case todayAiring(page: Int)
    case topRated(page: Int)

    var path: String {
        switch self {
        case .trending:
            return "/3/trending/tv/week"
        case .onAir:
            return "/3/tv/on_the_air"
        case .todayAiring:
            return "/3/tv/airing_today"
        case .topRated:
            return "/3/tv/top_rated"
        }
    }

    var parameters: [String: Any] {
        switch self {
        case let .trending(page), let .onAir(page), let .todayAiring(page), let .topRated(page):
            var params: [String: Any] = [:]
            params[ParameterKey.totalResults] = page
            return params
        }
    }

    var host: String {
        "api.themoviedb.org"
    }
}
