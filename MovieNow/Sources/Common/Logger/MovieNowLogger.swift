import Foundation
import Logging

let log = MovieNowLogger()

final class MovieNowLogger {
    private let log = Logger(label: "com.enne.MovieNow")
}

extension MovieNowLogger {
    func info(_ items: Any...) {
        let message = Logger.Message(stringLiteral: createMessage(from: items))
        log.info(message)
    }

    func error(_ items: Any...) {
        let message = Logger.Message(stringLiteral: createMessage(from: items))
        log.error(message)
    }
}

private extension MovieNowLogger {
    func createMessage(from items: [Any]) -> String {
        items
            .map { String(describing: $0) }
            .joined(separator: " ")
    }
}
