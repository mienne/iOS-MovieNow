import Foundation
import Network

final class NetworkChecker {
    static let shared = NetworkChecker()

    private let networkMonitor: NWPathMonitor
    private let queue: DispatchQueue

    private init() {
        networkMonitor = NWPathMonitor()
        queue = DispatchQueue.global()
        networkMonitor.start(queue: queue)
    }
}

// MARK: - Public

extension NetworkChecker {
    func start() {
        networkMonitor.pathUpdateHandler = { path in
            NotificationCenter.default.post(name: .isConnected, object: nil, userInfo: ["isConnected": path.status == .satisfied])
            NotificationCenter.default.post(name: .connectType, object: ConnectionType(path))
        }
    }

    func cancel() {
        networkMonitor.cancel()
    }
}
