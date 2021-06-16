import Foundation

enum MovieAPISetting: APISetting {
    case trending(page: Int)
    case nowPlaying(page: Int)
    case upcoming(page: Int)
    case topRated(page: Int)

    var path: String {
        switch self {
        case .trending:
            return "/3/trending/movie/week"
        case .nowPlaying:
            return "/3/movie/now_playing"
        case .upcoming:
            return "/3/movie/upcoming"
        case .topRated:
            return "/3/movie/top_rated"
        }
    }

    var parameters: [String: Any] {
        switch self {
        case let .trending(page), let .nowPlaying(page), let .upcoming(page), let .topRated(page):
            var params: [String: Any] = [:]
            params[ParameterKey.totalResults] = page
            return params
        }
    }

    var host: String {
        "api.themoviedb.org"
    }
}
