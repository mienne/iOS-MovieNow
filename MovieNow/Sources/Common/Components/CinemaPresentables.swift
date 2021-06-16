import Foundation

protocol CinemaPresentable {
    associatedtype CinemaPresenterType: RawRepresentable where CinemaPresenterType.RawValue == Int

    var movies: [MoviePresentable] { get set }
    var title: String { get }
    var hasMovies: Bool { get }
    var numberOfMovies: Int { get }
    var type: CinemaPresenterType { get set }

    subscript(at _: Int) -> MoviePresentable? { get }
}

extension CinemaPresentable {
    var hasMovies: Bool {
        !movies.isEmpty
    }

    var numberOfMovies: Int {
        movies.count
    }

    subscript(at index: Int) -> MoviePresentable? {
        guard hasMovies else { return nil }
        return movies[index]
    }
}
