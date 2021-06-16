import Foundation
import XCTest

@testable import MovieNow

class DetailRepositoryTests: XCTestCase {
    private var repository: DetailRepository!

    override func setUp() {
        continueAfterFailure = false
        repository = DefaultDetailRepository(MockAPIClient(MockAPIRequestManager()))
    }

    func testMovieDetailDataFetch() {
        repository.fetchVideos(apiSetting: MockAPISetting.movieDetail(id: 512_200)) { result in
            switch result {
            case let .success(detail):
                XCTAssertEqual(detail.id, 512_200)
                let result = detail.results?[0]
                XCTAssertEqual(result?.name, "JUMANJI: THE NEXT LEVEL - Official Trailer (HD)")
                XCTAssertEqual(result?.id, "5d1a1a9b30aa3163c6c5fe57")
                let result2 = detail.results?[1]
                XCTAssertEqual(result2?.name, "JUMANJI: THE NEXT LEVEL - Final Trailer (HD)")
                XCTAssertEqual(result2?.id, "5dbaf20c0792e100134ac14d")
            default:
                ()
            }
        }
    }

    func testTVDetailDataFetch() {
        repository.fetchVideos(apiSetting: MockAPISetting.tvDetail(id: 1403)) { result in
            switch result {
            case let .success(detail):
                XCTAssertEqual(detail.id, 1403)
                let result = detail.results?[0]
                XCTAssertEqual(result?.name, "Marvel's Agents of S.H.I.E.L.D. - Trailer 1 (Official)")
                XCTAssertEqual(result?.id, "552f8bc9c3a3686be2005df1")
            default:
                ()
            }
        }
    }
}
