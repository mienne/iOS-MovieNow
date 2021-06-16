import Foundation
import Network

enum ConnectionType {
    case wifi
    case ethernet
    case cellular
    case unknown

    init(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            self = .wifi
        } else if path.usesInterfaceType(.wiredEthernet) {
            self = .ethernet
        } else if path.usesInterfaceType(.cellular) {
            self = .cellular
        } else {
            self = .unknown
        }
    }
}
