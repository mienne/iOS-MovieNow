import Foundation

protocol MovieViewControllerType: AnyObject {
    func configureViewModel(_ viewModel: MovieViewModel)
}

protocol TVViewControllerType: AnyObject {
    func configureViewModel(_ viewModel: TVViewModel)
}
