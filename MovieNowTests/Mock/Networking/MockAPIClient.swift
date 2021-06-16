//
//  MockAPIClient.swift
//  MovieNowRepositoryTests
//
//  Created by hyeonjeong on 2020/03/13.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

@testable import MovieNow

class MockAPIClient: APIClient {
    private let apiRequestManager: APIRequestable

    required init(_ apiRequestManager: APIRequestable) {
        self.apiRequestManager = apiRequestManager
    }

    func sendRequest<T: Codable>(_ setting: APISetting, completion: @escaping (Result<T, Error>) -> Void) {
        apiRequestManager.requestData(with: createUrlRequest(setting)) { result in
            switch result {
            case let .success(data):
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(APIError.parsing))
                    return
                }

                completion(.success(decodedData))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func sendRequest<T: Codable>(_ setting: APISetting, completion: @escaping (Result<[T], Error>) -> Void) {
        apiRequestManager.requestData(with: createUrlRequest(setting)) { result in
            switch result {
            case let .success(data):
                guard let decodedData = try? JSONDecoder().decode([T].self, from: data) else {
                    completion(.failure(APIError.parsing))
                    return
                }

                completion(.success(decodedData))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func createUrlRequest(_ setting: APISetting) -> URLRequest {
        URLRequest(url: URL(fileURLWithPath: setting.path))
    }
}
