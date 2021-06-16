import Foundation

protocol MovieRepository {
    func fetchMovies(apiSetting: APISetting, completion: @escaping (Result<Movies, Error>) -> Void)
}
