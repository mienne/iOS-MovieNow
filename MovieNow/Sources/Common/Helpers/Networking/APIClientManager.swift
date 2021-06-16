//
//  APIClientManager.swift
//  Networking
//
//  Created by hyeonjeong on 2020/03/13.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

protocol APIClient {
    init(_ apiRequestManager: APIRequestable)

    func sendRequest(_ setting: APISetting, completion: @escaping (Result<Data, Error>) -> Void)
    func sendRequest<T: Codable>(_ setting: APISetting, completion: @escaping (Result<T, Error>) -> Void)
}

struct APIClientManager {
    private let apiRequestManager: APIRequestable

    init(_ apiRequestManager: APIRequestable = APIRequestManager.shared) {
        self.apiRequestManager = apiRequestManager
    }
}

// MARK: - Public: APIClient

extension APIClientManager: APIClient {
    func sendRequest(_ setting: APISetting, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let urlRequest = setting.createUrlRequest() else {
            completion(.failure(APIError.parsing))
            log.error("FAILURE: \(APIError.parsing.localizedDescription)")
            return
        }

        apiRequestManager.requestData(with: urlRequest) { result in
            switch result {
            case let .success(data):
                DispatchQueue.main.async {
                    log.info("SUCCESS: \(urlRequest)")
                    completion(.success(data))
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    log.error("FAILURE: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
    }

    func sendRequest<T: Codable>(_ setting: APISetting, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = setting.createUrlRequest() else {
            log.error("FAILURE: \(APIError.parsing.localizedDescription)")
            completion(.failure(APIError.parsing))
            return
        }

        apiRequestManager.requestData(with: urlRequest) { result in
            switch result {
            case let .success(data):
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    DispatchQueue.main.async {
                        log.error("FAILURE: \(APIError.parsing.localizedDescription)")
                        completion(.failure(APIError.parsing))
                    }
                    return
                }

                DispatchQueue.main.async {
                    log.info("SUCCESS: \(urlRequest)")
                    completion(.success(decodedData))
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    log.error("FAILURE: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
    }
}
