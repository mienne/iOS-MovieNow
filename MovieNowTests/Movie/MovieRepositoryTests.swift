import XCTest

@testable import MovieNow

class MovieRepositoryTests: XCTestCase {
    private var repository: MovieRepository!

    override func setUp() {
        continueAfterFailure = false
        repository = DefaultMovieRepository(MockAPIClient(MockAPIRequestManager()))
    }

    func testTrendingDataFetch() {
        repository.fetchMovies(apiSetting: MockAPISetting.movieTrending(page: 1)) { result in
            switch result {
            case let .success(movies):
                XCTAssertEqual(movies.page, 1)
                XCTAssertEqual(movies.results.count, 20)

                let movie = movies.results[1]
                XCTAssertEqual(movie.id, 330_457)
                XCTAssertEqual(movie.video, false)
                XCTAssertEqual(movie.voteAverage, 7.1)
                XCTAssertEqual(movie.title, "Frozen II")
                XCTAssertEqual(movie.releaseDate, "2019-11-20")
                XCTAssertEqual(movie.genreIds, [12, 16, 10751])
                XCTAssertEqual(movie.backdropPath, "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg")
                XCTAssertEqual(movie.posterPath, "/pjeMs3yqRmFL3giJy4PMXWZTTPa.jpg")
                XCTAssertEqual(movie.overview, "Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.")
            default:
                ()
            }
        }
    }

    func testUpcomingDataFetch() {
        repository.fetchMovies(apiSetting: MockAPISetting.movieUpcoming(page: 1)) { result in
            switch result {
            case let .success(movies):
                XCTAssertEqual(movies.page, 1)
                XCTAssertEqual(movies.results.count, 20)

                let movie = movies.results[2]
                XCTAssertEqual(movie.id, 647_785)
                XCTAssertEqual(movie.video, false)
                XCTAssertEqual(movie.voteAverage, 4)
                XCTAssertEqual(movie.title, "Debt Collectors")
                XCTAssertEqual(movie.releaseDate, "2020-05-29")
                XCTAssertEqual(movie.genreIds, [28])
                XCTAssertEqual(movie.overview, "A pair of debt collectors are thrust into an explosively dangerous situation, chasing down various lowlifes while also evading a vengeful kingpin.")
            default:
                ()
            }
        }
    }

    func testNowPlayingDataFetch() {
        repository.fetchMovies(apiSetting: MockAPISetting.movieNowPlaying(page: 1)) { result in
            switch result {
            case let .success(movies):
                XCTAssertEqual(movies.page, 1)
                XCTAssertEqual(movies.results.count, 20)

                let movie = movies.results[4]
                XCTAssertEqual(movie.id, 481_848)
                XCTAssertEqual(movie.video, false)
                XCTAssertEqual(movie.voteAverage, 7.40)
                XCTAssertEqual(movie.title, "The Call of the Wild")
                XCTAssertEqual(movie.releaseDate, "2020-02-19")
                XCTAssertEqual(movie.genreIds, [12, 18, 10751])
                XCTAssertEqual(movie.overview, "Buck is a big-hearted dog whose blissful domestic life is turned upside down when he is suddenly uprooted from his California home and transplanted to the exotic wilds of the Yukon during the Gold Rush of the 1890s. As the newest rookie on a mail delivery dog sled team—and later its leader—Buck experiences the adventure of a lifetime, ultimately finding his true place in the world and becoming his own master.")
            default:
                ()
            }
        }
    }
}
