import Foundation

@testable import MovieNow

class MockMovieRepository: MovieRepository {
    private let clientManager: APIClient

    required init(_ clientManager: APIClient) {
        self.clientManager = clientManager
    }

    func fetchMovies(apiSetting: APISetting, completion: @escaping (Result<Movies, Error>) -> Void) {
        clientManager.sendRequest(apiSetting, completion: completion)
    }
}
