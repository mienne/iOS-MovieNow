//
//  MockMovie.swift
//  MovieNowTests
//
//  Created by hyeonjeong on 2020/06/19.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

@testable import MovieNow

struct MockMoviePresenter: MoviePresentable {
    var detailAPISetting: APISetting {
        MockAPISetting.movieDetail(id: id)
    }

    var detailPosterPath: String {
        "/hreiLoPysWG79TsyQgMzFKaOTF5.jpg"
    }

    var id: Int {
        512_200
    }

    var overview: String {
        """
        As the gang return to Jumanji to rescue one of their own, they discover that nothing is as they expect. The players will have to brave parts unknown and unexplored in order to escape the world’s most dangerous game.
        """
    }

    var posterPath: String {
        "/bB42KDdfWkOvmzmYkmK58ZlCa9P.jpg"
    }

    var releaseDate: String {
        "2019-12-04"
    }

    var title: String {
        "Jumanji: The Next Level"
    }

    var voteAverage: String {
        "6.8"
    }
}
