//
//  APISetting.swift
//  Networking
//
//  Created by hyeonjeong on 2020/03/13.
//  Copyright © 2020 hyeonjeong. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol APISetting {
    var httpMethod: HttpMethod { get }
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [String: Any] { get }
}

extension APISetting {
    var httpMethod: HttpMethod {
        .get
    }

    var scheme: String {
        "https"
    }

    var parameters: [String: Any] {
        [:]
    }

    func createUrlString() -> String {
        "\(scheme)://\(host)/\(path)"
    }

    func createUrlRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path

        var queryItems: [URLQueryItem] = []

        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            queryItems.append(queryItem)
        }

        // TODO: - Adding API Key
        let apiKeyItem = URLQueryItem(name: "api_key", value: "740ebeeb4a658f1b04babc2c70f00390")
        queryItems.append(apiKeyItem)
        components.queryItems = queryItems

        if let url = components.url {
            return URLRequest(url: url)
        } else {
            return nil
        }
    }
}
