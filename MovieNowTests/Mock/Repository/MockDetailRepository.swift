//
//  MockDetailRepository.swift
//  MovieNowTests
//
//  Created by hyeonjeong on 2020/06/19.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

@testable import MovieNow

class MockDetailRepository: DetailRepository {
    private let clientManager: APIClient

    required init(_ clientManager: APIClient) {
        self.clientManager = clientManager
    }

    func fetchVideos(apiSetting: APISetting, completion: @escaping (Result<Videos, Error>) -> Void) {
        clientManager.sendRequest(apiSetting, completion: completion)
    }
}
