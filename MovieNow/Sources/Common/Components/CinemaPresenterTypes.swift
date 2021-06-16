import Foundation

protocol CinemaPresenterType {
    var title: String { get }
    var order: Int { get }

    func isEqual(type: CinemaPresenterType) -> Bool
}

protocol CinemaNormalPresenterType: CinemaPresenterType {
    func convert(page: Int) -> APISetting
}

protocol CinemaSearchPresenterType: CinemaPresenterType {
    func convert(query: String, page: Int) -> APISetting
}
