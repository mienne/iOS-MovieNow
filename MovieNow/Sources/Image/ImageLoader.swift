//
//  ImageLoadable.swift
//  MovieNow
//
//  Created by hyeonjeong on 2020/03/14.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

class ImageLoader {
    static let shared: ImageLoadable = ImageLoader()

    private let apiClient: APIClient

    private init() {
        apiClient = APIClientManager()
    }
}

// MARK: - Public: ImageLoadable

extension ImageLoader: ImageLoadable {
    func load(_ setting: APISetting, completion: @escaping (Result<Data, Error>) -> Void) {
        if let cachedData = ImageCache.shared.find(setting.createUrlString()) {
            DispatchQueue.main.async {
                completion(.success(cachedData))
            }
        } else {
            sendRequest(setting) { result in
                switch result {
                case let .success(data):
                    ImageCache.shared.save(setting.createUrlString(), content: data)
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}

// MARK: - Private

private extension ImageLoader {
    func sendRequest(_ setting: APISetting, completion: @escaping (Result<Data, Error>) -> Void) {
        apiClient.sendRequest(setting, completion: completion)
    }
}
