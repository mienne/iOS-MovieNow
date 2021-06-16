import Foundation

protocol SearchRepository {
    func find(apiSetting: APISetting, completion: @escaping (Result<MoviesResult, Error>) -> Void)
}
