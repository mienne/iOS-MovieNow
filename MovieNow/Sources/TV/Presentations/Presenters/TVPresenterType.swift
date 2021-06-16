import Foundation

enum TVPresenterType: Int {
    case onAir = 0
    case todayAiring = 1
    case trending = 2
    case topRated = 3
}

// MARK: - CinemaNormalPresenterType

extension TVPresenterType: CinemaNormalPresenterType {
    var title: String {
        switch self {
        case .onAir:
            return "On the Air"
        case .todayAiring:
            return "Today Airing"
        case .trending:
            return "Trending"
        case .topRated:
            return "Top Rated TV"
        }
    }

    var order: Int {
        rawValue
    }

    func convert(page: Int) -> APISetting {
        switch self {
        case .onAir:
            return TVAPISetting.onAir(page: page)
        case .todayAiring:
            return TVAPISetting.todayAiring(page: page)
        case .trending:
            return TVAPISetting.trending(page: page)
        case .topRated:
            return TVAPISetting.topRated(page: page)
        }
    }

    func isEqual(type: CinemaPresenterType) -> Bool {
        order == type.order
    }
}
