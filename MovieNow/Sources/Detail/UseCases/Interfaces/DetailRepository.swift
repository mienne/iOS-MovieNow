import Foundation

protocol DetailRepository {
    func fetchVideos(apiSetting: APISetting, completion: @escaping (Result<Videos, Error>) -> Void)
}
