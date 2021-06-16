import Foundation

struct DefaultMovieRepository {
    private let clientManager: APIClient

    init(_ clientManager: APIClient = APIClientManager()) {
        self.clientManager = clientManager
    }
}

// MARK: - Public: MovieRepository

extension DefaultMovieRepository: MovieRepository {
    func fetchMovies(apiSetting: APISetting, completion: @escaping (Result<Movies, Error>) -> Void) {
        clientManager.sendRequest(apiSetting, completion: completion)
    }
}
