import UIKit

protocol SearchResultViewWrapperDelegate: AnyObject {
    func loadMore(next request: SearchNextRequestPresenter)
}

class SearchResultViewWrapper: NSObject {
    private weak var tableView: UITableView!

    private lazy var viewController: SearchViewController? = {
        if let viewController = self.tableView?.findViewController() as? SearchViewController {
            return viewController
        } else {
            return nil
        }
    }()

    private lazy var segmentedControl: SearchResultSegementedControl = {
        let segmentedControl = SearchResultSegementedControl()
        return segmentedControl
    }()

    private var presenter: SearchResultPresenter<SearchResultPresenterType>?

    weak var delegate: SearchResultViewWrapperDelegate?

    init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
    }
}

// MARK: - Public: Reload

extension SearchResultViewWrapper {
    func reload(_ presenter: SearchResultPresenter<SearchResultPresenterType>? = nil) {
        self.presenter = presenter
        tableView.reloadData()
        segmentedControl.setType(presenter?.type ?? .movie)
    }
}

// MARK: - System Delegate: UITableViewDataSource, UITableViewDelegate

extension SearchResultViewWrapper: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        presenter?.numberOfMovies ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = presenter?[at: indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier) as? SearchResultCell
        else {
            return UITableViewCell()
        }
        cell.setUp(movie)
        return cell
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        50
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        segmentedControl.delegate = viewController
        return segmentedControl
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = presenter?[at: indexPath.row] else {
            return
        }
        let detailVC = DetailViewController.newInstance(movie)
        viewController?.navigationController?.present(detailVC, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        let needsFetch = distanceFromBottom < height
        if let presenter = presenter, needsFetch {
            let request = SearchNextRequestPresenter(
                text: presenter.keyword,
                type: presenter.type,
                movies: presenter.movies
            )
            delegate?.loadMore(next: request)
        }
    }
}
