import Foundation
import XCTest

@testable import MovieNow

class DetailUseCaseTests: XCTestCase {
    private var useCase: DetailUseCase!
    private var repository: DetailRepository!
    private var moviePresenter: MoviePresentable!

    override func setUp() {
        continueAfterFailure = false
        repository = MockDetailRepository(MockAPIClient(MockAPIRequestManager()))
        moviePresenter = MockMoviePresenter()
        useCase = DefaultDetailUseCase(repository)
    }

    func testDataLoad() {
        useCase.loadVideos(moviePresenter) { result in
            switch result {
            case let .success(presenter):
                XCTAssertNotNil(presenter)
                XCTAssertEqual(presenter?.numberOfItemsInSection, 2)
                XCTAssertEqual(presenter?.hasVideos, true)

                let video = presenter?[at: 1]
                XCTAssertEqual(video?.name, "JUMANJI: THE NEXT LEVEL - Final Trailer (HD)")
                XCTAssertEqual(video?.key, "F6QaLsw8EWY")
                XCTAssertEqual(video?.id, "5dbaf20c0792e100134ac14d")
            case .failure:
                ()
            }
        }
    }
}
