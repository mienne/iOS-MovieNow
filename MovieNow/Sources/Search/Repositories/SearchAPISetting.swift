import Foundation

enum SearchAPISetting: APISetting {
    case findMovie(query: String, page: Int)
    case findTV(query: String, page: Int)

    var path: String {
        switch self {
        case .findMovie:
            return "/3/search/movie"
        case .findTV:
            return "/3/search/tv"
        }
    }

    var parameters: [String: Any] {
        switch self {
        case let .findMovie(query, page), let .findTV(query, page):
            var params: [String: Any] = [:]
            params[ParameterKey.query] = query
            params[ParameterKey.page] = page
            return params
        }
    }

    var host: String {
        "api.themoviedb.org"
    }
}
