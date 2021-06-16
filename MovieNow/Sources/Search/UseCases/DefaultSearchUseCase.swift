import Foundation

struct DefaultSearchUseCase {
    private let repository: SearchRepository

    init(_ repository: SearchRepository) {
        self.repository = repository
    }
}

// MARK: - Public: SearchUseCase

extension DefaultSearchUseCase: SearchUseCase {
    func find(page: Int, request: SearchNextRequestPresenter, completion: @escaping (Result<SearchResultPresenter<SearchResultPresenterType>?, Error>) -> Void) {
        let apiSetting = request.type.convert(query: request.text, page: page)
        repository.find(apiSetting: apiSetting) { result in
            switch result {
            case let .success(data):
                if let datas = data.movies,
                   !datas.isEmpty
                {
                    let movies = request.movies + datas.map { $0.convert(request.type) }
                    completion(.success(SearchResultPresenter<SearchResultPresenterType>(text: request.text, type: request.type, movies)))
                } else {
                    completion(.success(nil))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
