import XCTest

@testable import MovieNow

class MovieUseCaseTests: XCTestCase {
    private var useCase: MovieUseCase!
    private var repository: MovieRepository!

    override func setUp() {
        continueAfterFailure = false
        repository = MockMovieRepository(MockAPIClient(MockAPIRequestManager()))
        useCase = DefaultMovieUseCase(repository)
    }

    func testDataLoad() {
        var presenters: [MoviesPresenter<MoviesPresenterType>] = []
        let expectation = self.expectation(description: "Movie Datas Load")
        useCase.loadDatas { [weak self] result in
            self?.repository.fetchMovies(apiSetting: MockAPISetting.movieNowPlaying(page: 1)) { result in
                switch result {
                case let .success(movies):
                    let presenter = MoviesPresenter<MoviesPresenterType>(type: .nowPlaying, movies: movies.results)
                    presenters.append(presenter)
                case .failure:
                    ()
                }
            }
            self?.repository.fetchMovies(apiSetting: MockAPISetting.movieTrending(page: 1)) { result in
                switch result {
                case let .success(movies):
                    let presenter = MoviesPresenter<MoviesPresenterType>(type: .trending, movies: movies.results)
                    presenters.append(presenter)
                case .failure:
                    ()
                }
            }
            self?.repository.fetchMovies(apiSetting: MockAPISetting.movieTopRate(page: 1)) { result in
                switch result {
                case let .success(movies):
                    let presenter = MoviesPresenter<MoviesPresenterType>(type: .topRated, movies: movies.results)
                    presenters.append(presenter)
                case .failure:
                    ()
                }
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 0.5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout error: \(error)")
            } else {
                XCTAssert(presenters.count == 2)
                XCTAssert(presenters[0].type == .nowPlaying)
                XCTAssert(presenters[0].movies.count == 20)
                XCTAssert(presenters[1].type != .topRated)
                XCTAssert(presenters[1].type == .trending)
                XCTAssert(presenters[1].movies.count == 20)
            }
        }
    }
}
