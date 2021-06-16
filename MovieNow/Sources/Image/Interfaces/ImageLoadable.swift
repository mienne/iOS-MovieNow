import Foundation

protocol ImageLoadable: AnyObject {
    func load(_ setting: APISetting, completion: @escaping (Result<Data, Error>) -> Void)
}
