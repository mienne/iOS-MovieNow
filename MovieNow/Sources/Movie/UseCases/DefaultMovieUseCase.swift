import Foundation

struct DefaultMovieUseCase {
    private let repository: MovieRepository

    init(_ repository: MovieRepository) {
        self.repository = repository
    }
}

// MARK: - Public: MovieUseCase

extension DefaultMovieUseCase: MovieUseCase {
    func loadDatas(completion: @escaping ([MoviesPresenter<MoviesPresenterType>]) -> Void) {
        var presenters: [MoviesPresenter<MoviesPresenterType>] = []
        let group = DispatchGroup()
        group.enter()
        loadMovies(page: 1, type: .nowPlaying) { result in
            switch result {
            case let .success(presenter):
                presenters.append(presenter)
                group.leave()
            case .failure:
                group.leave()
            }
        }
        group.enter()
        loadMovies(page: 1, type: .upcoming) { result in
            switch result {
            case let .success(presenter):
                presenters.append(presenter)
                group.leave()
            case .failure:
                group.leave()
            }
        }
        group.enter()
        loadMovies(page: 1, type: .trending) { result in
            switch result {
            case let .success(presenter):
                presenters.append(presenter)
                group.leave()
            case .failure:
                group.leave()
            }
        }
        group.enter()
        loadMovies(page: 1, type: .topRated) { result in
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

private extension DefaultMovieUseCase {
    func loadMovies(page: Int, type: MoviesPresenterType, completion: @escaping (Result<MoviesPresenter<MoviesPresenterType>, Error>) -> Void) {
        repository.fetchMovies(apiSetting: type.convert(page: page)) { result in
            switch result {
            case let .success(movies):
                completion(.success(MoviesPresenter<MoviesPresenterType>(type: type, movies: movies.results)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
