import XCTest

@testable import MovieNow

class TVRepositoryTests: XCTestCase {
    private var repository: TVRepository!

    override func setUp() {
        continueAfterFailure = false
        repository = DefaultTVRepository(MockAPIClient(MockAPIRequestManager()))
    }

    func testTrendingDataFetch() {
        repository.fetchTVDatas(apiSetting: MockAPISetting.tvTrending(page: 1)) { result in
            switch result {
            case let .success(shows):
                XCTAssertEqual(shows.page, 1)
                XCTAssertEqual(shows.results.count, 20)

                let show = shows.results[0]
                XCTAssertEqual(show.id, 68421)
                XCTAssertEqual(show.name, "Altered Carbon")
                XCTAssertEqual(show.firstAirDate, "2018-02-02")
                XCTAssertEqual(show.posterPath, "/95IsiH4p5937YXQHaOS2W2dWYOG.jpg")
                XCTAssertEqual(show.genreIds, [10765])
                XCTAssertEqual(show.backdropPath, "/xETbCo8l06poxFUgbtaUeKmLadz.jpg")
                XCTAssertEqual(show.voteAverage, 7.9)
                XCTAssertEqual(show.overview, "After 250 years on ice, a prisoner returns to life in a new body with one chance to win his freedom: by solving a mind-bending murder.")
            default:
                ()
            }
        }
    }

    func testAiringTodayDataFetch() {
        repository.fetchTVDatas(apiSetting: MockAPISetting.tvTodayAiring(page: 1)) { result in
            switch result {
            case let .success(shows):
                XCTAssertEqual(shows.page, 1)
                XCTAssertEqual(shows.results.count, 20)

                let show = shows.results[3]
                XCTAssertEqual(show.id, 62643)
                XCTAssertEqual(show.name, "DC's Legends of Tomorrow")
                XCTAssertEqual(show.firstAirDate, "2016-01-21")
                XCTAssertEqual(show.genreIds, [18, 10759, 10765])
                XCTAssertEqual(show.voteAverage, 6.8)
                XCTAssertEqual(show.overview, "When heroes alone are not enough ... the world needs legends. Having seen the future, one he will desperately try to prevent from happening, time-traveling rogue Rip Hunter is tasked with assembling a disparate group of both heroes and villains to confront an unstoppable threat — one in which not only is the planet at stake, but all of time itself. Can this ragtag team defeat an immortal threat unlike anything they have ever known?")
            default:
                ()
            }
        }
    }
}
