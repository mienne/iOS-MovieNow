
import Foundation

final class ImageCache {
    private let cacheDirectoryUrl: URL = {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }()

    static let shared = ImageCache()
}

// MARK: - Public

extension ImageCache {
    func find(_ urlString: String) -> Data? {
        let url = cacheDirectoryUrl.appendingPathComponent(urlString)
        return FileManager.default.contents(atPath: url.path)
    }

    func save(_ urlString: String, content data: Data) {
        let url = cacheDirectoryUrl.appendingPathComponent(urlString)

        do {
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }

            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            print(error.localizedDescription)
        }
    }

    func removeAll() {
        do {
            let fileUrls = try FileManager.default.contentsOfDirectory(atPath: cacheDirectoryUrl.path)

            for fileUrl in fileUrls {
                try FileManager.default.removeItem(atPath: fileUrl)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
