import Foundation

protocol MovieUseCase {
    func loadDatas(completion: @escaping ([MoviesPresenter<MoviesPresenterType>]) -> Void)
}
