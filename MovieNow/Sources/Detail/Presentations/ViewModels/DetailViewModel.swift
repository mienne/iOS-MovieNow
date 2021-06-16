import Foundation

struct DetailViewModel {
    private let useCase: DetailUseCase

    var onSuccess: ((VideosPresenter?) -> Void) = { _ in }
    var onFailure: ((Error) -> Void) = { _ in }

    init(_ useCase: DetailUseCase) {
        self.useCase = useCase
    }

    func fetch(_ movie: MoviePresentable) {
        useCase.loadVideos(movie) { result in
            switch result {
            case let .success(presenter):
                self.onSuccess(presenter)
            case let .failure(error):
                self.onFailure(error)
            }
        }
    }
}
