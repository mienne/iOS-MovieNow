import Foundation

@testable import MovieNow

enum MockAPISetting: APISetting {
    case movieTrending(page: Int)
    case movieUpcoming(page: Int)
    case movieNowPlaying(page: Int)
    case movieTopRate(page: Int)
    case tvTrending(page: Int)
    case tvTodayAiring(page: Int)
    case movieDetail(id: Int)
    case tvDetail(id: Int)

    var httpMethod: HttpMethod {
        .get
    }

    var scheme: String {
        ""
    }

    var host: String {
        ""
    }

    var path: String {
        let bundle = Bundle(identifier: "com.enne.MovieNowTests")
        switch self {
        case .movieTrending:
            return bundle?.path(forResource: "movie_trending", ofType: "json") ?? ""
        case .movieUpcoming:
            return bundle?.path(forResource: "movie_upcoming", ofType: "json") ?? ""
        case .movieNowPlaying:
            return bundle?.path(forResource: "movie_now_playing", ofType: "json") ?? ""
        case .movieTopRate:
            return ""
        case .tvTrending:
            return bundle?.path(forResource: "tv_trending", ofType: "json") ?? ""
        case .tvTodayAiring:
            return bundle?.path(forResource: "tv_airing_today", ofType: "json") ?? ""
        case .movieDetail:
            return bundle?.path(forResource: "movie_detail", ofType: "json") ?? ""
        case .tvDetail:
            return bundle?.path(forResource: "tv_detail", ofType: "json") ?? ""
        }
    }

    var parameters: [String: Any] {
        [:]
    }
}
