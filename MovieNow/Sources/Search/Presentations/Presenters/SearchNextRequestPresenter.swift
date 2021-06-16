//
//  SearchNextRequestPresenter.swift
//  MovieNow
//
//  Created by hyeonjeong on 2020/04/16.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

struct SearchNextRequestPresenter {
    let text: String
    let type: SearchResultPresenterType
    let movies: [MoviePresentable]

    var hasMovies: Bool {
        !movies.isEmpty
    }

    init(text: String, type: SearchResultPresenterType, movies: [MoviePresentable]) {
        self.text = text
        self.type = type
        self.movies = movies
    }
}
