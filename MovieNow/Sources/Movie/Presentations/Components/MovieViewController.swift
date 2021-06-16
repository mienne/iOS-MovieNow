import UIKit

class MovieViewController: BaseViewController {
    private typealias TrendingViewController = GenericCollectionViewController<MovieContentView, GenericCollectionViewCell<MovieContentView>>

    private typealias NowPlayingViewController = GenericCollectionViewController<MovieContentView, GenericCollectionViewCell<MovieContentView>>

    private typealias UpcomingViewController = GenericCollectionViewController<MovieContentView, GenericCollectionViewCell<MovieContentView>>

    private typealias TopRatedViewController = GenericCollectionViewController<MovieContentView, GenericCollectionViewCell<MovieContentView>>

    private lazy var trendingTitleLabel: UILabel = {
        MovieCollectionViewType.trending.createTitleLabel()
    }()

    private lazy var trendingController: TrendingViewController = {
        let controller = TrendingViewController(view: MovieContentView.self, type: MovieCollectionViewType.trending)
        return controller
    }()

    private lazy var nowPlayingTitleLabel: UILabel = {
        MovieCollectionViewType.nowPlaying.createTitleLabel()
    }()

    private lazy var nowPlayingController: NowPlayingViewController = {
        let controller = NowPlayingViewController(view: MovieContentView.self, type: MovieCollectionViewType.nowPlaying)
        return controller
    }()

    private lazy var upcomingTitleLabel: UILabel = {
        MovieCollectionViewType.upcoming.createTitleLabel()
    }()

    private lazy var upcomingController: UpcomingViewController = {
        let controller = UpcomingViewController(view: MovieContentView.self, type: MovieCollectionViewType.upcoming)
        return controller
    }()

    private lazy var topRatedTitleLabel: UILabel = {
        MovieCollectionViewType.topRated.createTitleLabel()
    }()

    private lazy var topRatedController: TopRatedViewController = {
        let controller = TopRatedViewController(view: MovieContentView.self, type: MovieCollectionViewType.topRated)
        return controller
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var scrollContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()

    private var viewModel: MovieViewModel!
}

// MARK: - Life Cycle

extension MovieViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollViewLayout()
        configureScrollContentViewLayout()
    }
}

// MARK: - Public: MovieViewControllerType

extension MovieViewController: MovieViewControllerType {
    func configureViewModel(_ viewModel: MovieViewModel) {
        self.viewModel = viewModel
        self.viewModel.onSuccess = { [weak self] presenter in
            self?.configureView(presenter)
        }
        self.viewModel.fetch()
    }
}

// MARK: - Private: Configure Layouts

private extension MovieViewController {
    func configureScrollViewLayout() {
        view.addSubview(scrollView)
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func configureScrollContentViewLayout() {
        scrollView.addSubview(scrollContentView)
        let constraints = [
            scrollContentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 5),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Private: Configure UI

private extension MovieViewController {
    func configureView(_ presenters: [MoviesPresenter<MoviesPresenterType>]) {
        for (index, presenter) in presenters.enumerated() {
            if MoviesPresenterType.nowPlaying.isEqual(type: presenter.type) {
                configureContentView(index: index, presenter: presenter, titleLabel: nowPlayingTitleLabel, viewController: nowPlayingController)
            } else if MoviesPresenterType.topRated.isEqual(type: presenter.type) {
                configureContentView(index: index, presenter: presenter, titleLabel: topRatedTitleLabel, viewController: topRatedController)
            } else if MoviesPresenterType.trending.isEqual(type: presenter.type) {
                configureContentView(index: index, presenter: presenter, titleLabel: trendingTitleLabel, viewController: trendingController)
            } else {
                configureContentView(index: index, presenter: presenter, titleLabel: upcomingTitleLabel, viewController: upcomingController)
            }
        }
    }

    func configureContentView(index _: Int, presenter: MoviesPresenter<MoviesPresenterType>, titleLabel: UILabel, viewController: GenericCollectionViewController<MovieContentView, GenericCollectionViewCell<MovieContentView>>) {
        let contentView = UIView()
        contentView.addSubview(titleLabel)
        let titleConstraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15)
        ]
        NSLayoutConstraint.activate(titleConstraints)

        let constraints: [NSLayoutConstraint] = [
            viewController.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            viewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewController.view.heightAnchor.constraint(equalToConstant: MovieContentView.Metric.itemSize.height)
        ]

        addChildViewController(viewController, containerView: contentView, constraints: constraints)
        scrollContentView.addArrangedSubview(contentView)
        let height = 30 + MovieContentView.Metric.itemSize.height + 10
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.heightAnchor.constraint(equalToConstant: height).isActive = true

        titleLabel.text = presenter.title
        viewController.numberOfItems = { presenter.numberOfMovies }
        viewController.configureView = { indexPath, view in
            if let movie = presenter[at: indexPath.row] {
                view.setup(movie)
            }
        }
        viewController.didSelectView = { [weak self] indexPath, _ in
            guard let movie = presenter[at: indexPath.row] else {
                return
            }
            let viewController = DetailViewController.newInstance(movie)
            self?.navigationController?.present(viewController, animated: true)
        }
    }
}
