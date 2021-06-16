import Foundation

struct DefaultDetailUseCase {
    private let repository: DetailRepository

    init(_ repository: DetailRepository) {
        self.repository = repository
    }
}

// MARK: - Public: DetailUseCase

extension DefaultDetailUseCase: DetailUseCase {
    func loadVideos(_ movie: MoviePresentable, completion: @escaping (Result<VideosPresenter?, Error>) -> Void) {
        repository.fetchVideos(apiSetting: movie.detailAPISetting) { result in
            switch result {
            case let .success(data):
                if let videos = data.results {
                    completion(.success(VideosPresenter(videos)))
                } else {
                    completion(.success(nil))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
