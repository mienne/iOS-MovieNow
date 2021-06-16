import Foundation

struct DefaultTVRepository {
    private let clientManager: APIClient

    init(_ clientManager: APIClient = APIClientManager()) {
        self.clientManager = clientManager
    }
}

// MARK: - Public: TVRepository

extension DefaultTVRepository: TVRepository {
    func fetchTVDatas(apiSetting: APISetting, completion: @escaping (Result<Movies, Error>) -> Void) {
        clientManager.sendRequest(apiSetting, completion: completion)
    }
}
