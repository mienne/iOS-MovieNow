import Foundation

@testable import MovieNow

class MockAPIRequestManager: APIRequestable {
    func requestData(with urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = urlRequest.url else {
            return
        }

        if let data = try? Data(contentsOf: url) {
            completion(.success(data))
        } else {
            completion(.failure(APIError.unknown))
        }
    }
}
