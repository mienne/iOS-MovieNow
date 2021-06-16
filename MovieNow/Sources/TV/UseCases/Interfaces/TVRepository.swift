import Foundation

protocol TVRepository {
    func fetchTVDatas(apiSetting: APISetting, completion: @escaping (Result<Movies, Error>) -> Void)
}
