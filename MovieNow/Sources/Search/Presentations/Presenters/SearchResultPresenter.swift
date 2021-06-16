//
//  SearchResultsPresenter.swift
//  MovieNow
//
//  Created by hyeonjeong on 2020/03/30.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

struct SearchResultPresenter<PresenterType: CinemaPresenterType>: CinemaSearchPresentable {
    typealias PresenterType = SearchResultPresenterType

    var movies: [MoviePresentable]
    var keyword: String = ""
    var type: SearchResultPresenterType

    var title: String {
        type.title
    }

    init(text: String, type: SearchResultPresenterType, _ movies: [MoviePresentable]) {
        keyword = text
        self.type = type
        self.movies = movies
    }
}
