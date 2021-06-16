import Foundation

struct TVPresenter<PresenterType: CinemaPresenterType>: CinemaPresentable {
    typealias PresenterType = TVPresenterType

    var movies: [MoviePresentable]
    var type: TVPresenterType

    var title: String {
        type.title
    }

    init(type: TVPresenterType, movies: [Movie]) {
        self.type = type
        self.movies = movies.map { $0.convert(type) }
    }
}
