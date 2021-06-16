import Foundation

protocol MoviePresentable {
    var detailAPISetting: APISetting { get }
    var detailPosterPath: String { get }
    var id: Int { get }
    var overview: String { get }
    var posterPath: String { get }
    var releaseDate: String { get }
    var title: String { get }
    var voteAverage: String { get }
}

struct MoviePresenter {
    private let movie: Movie
    private let type: CinemaPresenterType

    init(_ movie: Movie, type: CinemaPresenterType) {
        self.movie = movie
        self.type = type
    }
}

// MARK: - Public: MoviePresentable

extension MoviePresenter: MoviePresentable {
    var detailAPISetting: APISetting {
        if isMovieType {
            return DetailAPISetting.movieVideos(id: id)
        } else {
            return DetailAPISetting.tvVideos(id: id)
        }
    }

    var detailPosterPath: String {
        movie.backdropPath ?? ""
    }

    var id: Int {
        movie.id ?? -1
    }

    var overview: String {
        movie.overview ?? ""
    }

    var posterPath: String {
        movie.posterPath ?? ""
    }

    var releaseDate: String {
        movie.releaseDate ?? ""
    }

    var title: String {
        movie.title ?? movie.name ?? ""
    }

    var voteAverage: String {
        "\(movie.voteAverage ?? 0)"
    }
}

// MARK: - Private

private extension MoviePresenter {
    var isMovieType: Bool {
        if let type = type as? SearchResultPresenterType, type == .movie {
            return true
        } else if type is MoviesPresenterType {
            return true
        } else {
            return false
        }
    }
}
