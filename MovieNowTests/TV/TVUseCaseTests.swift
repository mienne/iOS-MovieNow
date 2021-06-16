import XCTest

@testable import MovieNow

class TVUseCaseTests: XCTestCase {
    private var useCase: TVUseCase!
    private var repository: TVRepository!

    override func setUp() {
        continueAfterFailure = false
        repository = MockTVRepository(MockAPIClient(MockAPIRequestManager()))
        useCase = DefaultTVUseCase(repository)
    }

    func testTVDataLoad() {
        var presenters: [TVPresenter<TVPresenterType>] = []
        let expectation = self.expectation(description: "TV Datas Load")
        useCase.loadDatas { [weak self] result in
            self?.repository.fetchTVDatas(apiSetting: MockAPISetting.tvTrending(page: 1)) { result in
                switch result {
                case let .success(tv):
                    let presenter = TVPresenter<TVPresenterType>(type: .trending, movies: tv.results)
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
                XCTAssert(presenters.count == 1)
                XCTAssert(presenters[0].type == .trending)
                XCTAssert(presenters[0].movies.count == 20)
            }
        }
    }
}
