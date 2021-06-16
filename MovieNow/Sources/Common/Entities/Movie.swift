import Foundation

struct Movie {
    let profilePath: String?
    let posterPath: String?
    let title: String?
    let backdropPath: String?
    let poster: String?
    let overview: String?
    let releaseDate: String?
    let video: Bool?
    let runtime: Int?
    let id: Int?
    let genreIds: [Int]?
    let popularity: Double?
    let voteAverage: Double?
    let firstAirDate: String?
    let name: String?
    let birthday: String?
}

// MARK: - Public: Codable

extension Movie: Codable {
    enum CodingKeys: String, CodingKey {
        case profilePath = "profile_path"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
        case title, poster, overview, video, runtime, id, popularity, name, birthday
    }
}

// MARK: - Public: Converting

extension Movie {
    func convert(_ presenterType: CinemaPresenterType) -> MoviePresentable {
        MoviePresenter(self, type: presenterType)
    }
}
