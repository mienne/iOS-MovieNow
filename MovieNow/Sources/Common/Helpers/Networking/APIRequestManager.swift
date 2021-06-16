//
//  APIRequestManager.swift
//  Networking
//
//  Created by hyeonjeong on 2020/03/13.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

protocol APIRequestable {
    func requestData(with urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

struct APIRequestManager {
    static let shared = APIRequestManager(session: URLSession.shared)

    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }
}

// MARK: - Public: APIRequestable

extension APIRequestManager: APIRequestable {
    func requestData(with urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(error ?? APIError.unknown))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.unknown))
                return
            }

            guard 200 ..< 300 ~= httpResponse.statusCode else {
                if httpResponse.statusCode == 429,
                   (httpResponse.allHeaderFields["Retry-After"] as? String) != nil
                {
                    completion(.failure(APIError.retryAfter))
                } else {
                    completion(.failure(APIError.server))
                }

                return
            }

            guard let data = data else {
                completion(.failure(APIError.unknown))
                return
            }

            completion(.success(data))
        }.resume()
    }
}
