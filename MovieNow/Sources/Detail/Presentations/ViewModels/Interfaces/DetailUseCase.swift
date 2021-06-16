import Foundation

protocol DetailUseCase {
    func loadVideos(_ movie: MoviePresentable, completion: @escaping (Result<VideosPresenter?, Error>) -> Void)
}
