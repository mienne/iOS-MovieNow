import Foundation

struct DefaultSearchRepository {
    private let clientManager: APIClient

    init(_ clientManager: APIClient = APIClientManager()) {
        self.clientManager = clientManager
    }
}

// MARK: - Public: SearchRepository

extension DefaultSearchRepository: SearchRepository {
    func find(apiSetting: APISetting, completion: @escaping (Result<MoviesResult, Error>) -> Void) {
        clientManager.sendRequest(apiSetting, completion: completion)
    }
}
