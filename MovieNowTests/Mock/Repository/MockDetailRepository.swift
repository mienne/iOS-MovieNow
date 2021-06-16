import Foundation

@testable import MovieNow

class MockDetailRepository: DetailRepository {
    private let clientManager: APIClient

    required init(_ clientManager: APIClient) {
        self.clientManager = clientManager
    }

    func fetchVideos(apiSetting: APISetting, completion: @escaping (Result<Videos, Error>) -> Void) {
        clientManager.sendRequest(apiSetting, completion: completion)
    }
}
