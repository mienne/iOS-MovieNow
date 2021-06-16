import Foundation

protocol SearchUseCase {
    func find(page: Int, request: SearchNextRequestPresenter, completion: @escaping (Result<SearchResultPresenter<SearchResultPresenterType>?, Error>) -> Void)
}
