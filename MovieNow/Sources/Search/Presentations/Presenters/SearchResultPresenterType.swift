//
//  SearchResultPresenterType.swift
//  MovieNow
//
//  Created by hyeonjeong on 2020/04/05.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

enum SearchResultPresenterType: Int, CaseIterable {
    case movie = 0
    case tv
}

// MARK: - Public: CinemaSearchPresenterType

extension SearchResultPresenterType: CinemaSearchPresenterType {
    var order: Int {
        rawValue
    }

    var title: String {
        switch self {
        case .movie:
            return "Movie"
        case .tv:
            return "TV"
        }
    }

    func convert(query: String, page: Int) -> APISetting {
        switch self {
        case .movie:
            return SearchAPISetting.findMovie(query: query, page: page)
        case .tv:
            return SearchAPISetting.findTV(query: query, page: page)
        }
    }

    func isEqual(type: CinemaPresenterType) -> Bool {
        order == type.order
    }
}
