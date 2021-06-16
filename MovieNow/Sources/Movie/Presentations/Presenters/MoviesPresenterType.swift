import Foundation

enum MoviesPresenterType: Int {
    case nowPlaying = 1
    case upcoming = 0
    case trending = 2
    case topRated = 3
}

// MARK: - Public: CinemaNormalPresenterType

extension MoviesPresenterType: CinemaNormalPresenterType {
    var title: String {
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top Rated Movies"
        }
    }

    var order: Int {
        rawValue
    }

    func convert(page: Int) -> APISetting {
        switch self {
        case .trending:
            return MovieAPISetting.trending(page: page)
        case .nowPlaying:
            return MovieAPISetting.nowPlaying(page: page)
        case .upcoming:
            return MovieAPISetting.upcoming(page: page)
        case .topRated:
            return MovieAPISetting.topRated(page: page)
        }
    }

    func isEqual(type: CinemaPresenterType) -> Bool {
        order == type.order
    }
}
