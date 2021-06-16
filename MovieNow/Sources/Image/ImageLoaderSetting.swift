import Foundation

enum ImageLoaderSetting: APISetting {
    case trending(size: ImageSize, path: String)
    case detail(size: ImageSize, path: String)

    var host: String {
        "image.tmdb.org"
    }

    var path: String {
        switch self {
        case let .trending(size, path), let .detail(size, path):
            return "/t/p/\(size.value)\(path)"
        }
    }
}
