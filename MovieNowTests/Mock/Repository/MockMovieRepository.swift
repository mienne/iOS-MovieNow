//
//  MockMovieRepository.swift
//  MovieNowRepositoryTests
//
//  Created by hyeonjeong on 2020/03/13.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

@testable import MovieNow

class MockMovieRepository: MovieRepository {
    private let clientManager: APIClient

    required init(_ clientManager: APIClient) {
        self.clientManager = clientManager
    }

    func fetchMovies(apiSetting: APISetting, completion: @escaping (Result<Movies, Error>) -> Void) {
        clientManager.sendRequest(apiSetting, completion: completion)
    }
}
