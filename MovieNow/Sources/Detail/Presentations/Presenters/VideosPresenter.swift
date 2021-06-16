import Foundation

struct VideosPresenter {
    private let videos: [Video]

    var hasVideos: Bool {
        !videos.isEmpty
    }

    var numberOfItemsInSection: Int {
        videos.count
    }

    init(_ videos: [Video]) {
        self.videos = videos
    }

    subscript(at index: Int) -> Video? {
        guard hasVideos else { return nil }
        return videos[index]
    }
}
