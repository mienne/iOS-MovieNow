import Foundation

struct DefaultDetailRepository {
    private let clientManager: APIClient

    init(_ clientManager: APIClient = APIClientManager()) {
        self.clientManager = clientManager
    }
}

// MARK: - DetailRepository

extension DefaultDetailRepository: DetailRepository {
    func fetchVideos(apiSetting: APISetting, completion: @escaping (Result<Videos, Error>) -> Void) {
        clientManager.sendRequest(apiSetting, completion: completion)
    }
}
