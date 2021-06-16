import UIKit

protocol SearchViewControllerType: AnyObject {
    func configureViewModel(_ viewModel: SearchViewModel)
}

class SearchViewController: BaseViewController {
    private lazy var resultViewWrapper: SearchResultViewWrapper = {
        let wrapper = SearchResultViewWrapper(self.tableView)
        wrapper.delegate = self
        return wrapper
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.systemBackground
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()

    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.allowsDefaultTighteningForTruncation = true
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No result."
        return label
    }()

    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel: SearchViewModel!
}

// MARK: - Life Cycle

extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureTableViewLayout()
        configureEmptyViewLayout()
        configureSearchBar()
        resultViewWrapper.reload(.none)
    }
}

// MARK: - Public: SearchViewControllerType

extension SearchViewController: SearchViewControllerType {
    func configureViewModel(_ viewModel: SearchViewModel) {
        self.viewModel = viewModel
        self.viewModel.onSuccess = { [weak self] presenter in
            if let presenter = presenter {
                self?.emptyView.isHidden = true
                self?.resultViewWrapper.reload(presenter)
            } else {
                self?.emptyView.isHidden = false
            }
        }
        self.viewModel.onFailure = { [weak self] _ in
            self?.emptyView.isHidden = false
        }
    }
}

// MARK: - System Delegate: UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        dismissKeyboard()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        showKeyboard()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        dismissKeyboard()
    }
}

// MARK: - System Delegate: UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        viewModel.update(to: text)
    }
}

// MARK: - Delegate: SearchResultSegementedControlDelegate

extension SearchViewController: SearchResultSegementedControlDelegate {
    func change(to type: SearchResultPresenterType) {
        viewModel.update(to: type)
    }
}

// MARK: - Delegate: SearchResultViewWrapperDelegate

extension SearchViewController: SearchResultViewWrapperDelegate {
    func loadMore(next request: SearchNextRequestPresenter) {
        viewModel.update(next: request)
    }
}

// MARK: - Private: Configure UI

private extension SearchViewController {
    func configureTableViewLayout() {
        view.addSubview(tableView)
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func configureEmptyViewLayout() {
        view.addSubview(emptyView)
        emptyView.addSubview(emptyLabel)
        let constraints = [
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }

    func configureTableView() {
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        tableView.rowHeight = 120
        tableView.estimatedRowHeight = 120
        tableView.dataSource = resultViewWrapper
        tableView.delegate = resultViewWrapper
        tableView.separatorStyle = .none
        tableView.separatorInset = .zero
    }
}

// MARK: - Private: Show/Hide a keyboard

private extension SearchViewController {
    func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }

    func showKeyboard() {
        searchController.searchBar.becomeFirstResponder()
    }
}
