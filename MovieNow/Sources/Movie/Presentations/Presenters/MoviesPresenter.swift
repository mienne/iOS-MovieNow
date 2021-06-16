import Foundation

struct MoviesPresenter<PresenterType: CinemaPresenterType>: CinemaPresentable {
    typealias PresenterType = MoviesPresenterType

    var movies: [MoviePresentable]
    var type: MoviesPresenterType

    var title: String {
        type.title
    }

    init(type: MoviesPresenterType, movies: [Movie]) {
        self.type = type
        self.movies = movies.map { $0.convert(type) }
    }
}
