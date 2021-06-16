import Foundation

struct DefaultTVUseCase {
    private let repository: TVRepository

    init(_ repository: TVRepository) {
        self.repository = repository
    }
}

// MARK: - Public: TVUseCase

extension DefaultTVUseCase: TVUseCase {
    func loadDatas(completion: @escaping ([TVPresenter<TVPresenterType>]) -> Void) {
        var presenters: [TVPresenter<TVPresenterType>] = []
        let group = DispatchGroup()
        group.enter()
        loadTV(page: 1, type: .todayAiring) { result in
            switch result {
            case let .success(presenter):
                presenters.append(presenter)
                group.leave()
            case .failure:
                group.leave()
            }
        }
        group.enter()
        loadTV(page: 1, type: .onAir) { result in
            switch result {
            case let .success(presenter):
                presenters.append(presenter)
                group.leave()
            case .failure:
                group.leave()
            }
        }
        group.enter()
        loadTV(page: 1, type: .trending) { result in
            switch result {
            case let .success(presenter):
                presenters.append(presenter)
                group.leave()
            case .failure:
                group.leave()
            }
        }
        group.enter()
        loadTV(page: 1, type: .topRated) { result in
            switch result {
            case let .success(presenter):
                presenters.append(presenter)
                group.leave()
            case .failure:
                group.leave()
            }
        }
        group.notify(queue: .main) {
            presenters.sort { $0.type.order < $1.type.order }
            completion(presenters)
        }
    }
}

// MARK: - Private

private extension DefaultTVUseCase {
    func loadTV(page: Int, type: TVPresenterType, completion: @escaping (Result<TVPresenter<TVPresenterType>, Error>) -> Void) {
        repository.fetchTVDatas(apiSetting: type.convert(page: page)) { result in
            switch result {
            case let .success(movies):
                completion(.success(TVPresenter<TVPresenterType>(type: type, movies: movies.results)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
