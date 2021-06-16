import UIKit

class DetailViewController: BaseViewController {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "ic_close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = UIColor.label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var overviewTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.contentInsetAdjustmentBehavior = .never
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textView.textColor = UIColor.label
        return textView
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = TrailerCell.Metric.itemSize
        layout.headerReferenceSize = .zero
        layout.footerReferenceSize = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.systemBackground
        return collectionView
    }()

    private lazy var detailViewWrapper: DetailViewWrapper = {
        let wrapper = DetailViewWrapper(self.collectionView)
        return wrapper
    }()

    private var movie: MoviePresentable!
    private var viewModel: DetailViewModel!
}

// MARK: - Life Cycle

extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDatas()
        configureLayout()
        configureViews()
    }
}

// MARK: - Public

extension DetailViewController {
    func configureLayout() {
        configureScrollViewLayout()
        configureBackgroundImageViewLayout()
        configureCloseButtonLayout()
        configureLabelsLayout()
        configureOverviewTextViewLayout()
        configureCollectionViewLayout()
    }

    func configureViews() {
        configureCollectionView()
        configureBackgroundImageView()
        configureLabels()
        configureOverviewTextView()
    }
}

// MARK: - Public: A new instance

extension DetailViewController {
    static func newInstance(_ movie: MoviePresentable) -> DetailViewController {
        let viewController = UIStoryboard.viewController(self, at: "Detail")
        viewController.movie = movie
        viewController.viewModel = DetailViewModel(DefaultDetailUseCase(DefaultDetailRepository()))
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}

// MARK: - Private: Loading datas

private extension DetailViewController {
    func loadDatas() {
        viewModel.onSuccess = { [weak self] presenter in
            self?.detailViewWrapper.setUp(presenter)
        }
        viewModel.onFailure = { [weak self] _ in
            self?.detailViewWrapper.setUp(.none)
        }
        viewModel.fetch(movie)
    }
}

// MARK: - Private: Configure Layouts

private extension DetailViewController {
    func configureScrollViewLayout() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func configureBackgroundImageViewLayout() {
        scrollView.addSubview(backgroundImageView)
        scrollView.addSubview(indicatorView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: view.frame.width),
            backgroundImageView.heightAnchor.constraint(equalTo:
                backgroundImageView.widthAnchor, multiplier: 2 / 3),
            indicatorView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 30),
            indicatorView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configureCloseButtonLayout() {
        scrollView.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchDown)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    @objc func didTapCloseButton(_: UIButton) {
        dismiss(animated: true)
    }

    func configureLabelsLayout() {
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(releaseDateLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 15),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            releaseDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            releaseDateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }

    func configureOverviewTextViewLayout() {
        scrollView.addSubview(overviewTextView)
        NSLayoutConstraint.activate([
            overviewTextView.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 10),
            overviewTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            overviewTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }

    func configureCollectionViewLayout() {
        scrollView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: overviewTextView.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: TrailerCell.Metric.itemHeight)
        ])
    }
}

// MARK: - Private: Configure UI

private extension DetailViewController {
    func configureBackgroundImageView() {
        indicatorView.startAnimating()
        ImageLoader.shared.load(ImageLoaderSetting.detail(size: .w500, path: movie.detailPosterPath)) { [weak self] result in
            switch result {
            case let .success(data):
                self?.indicatorView.stopLoadingAnimation()
                self?.backgroundImageView.image = UIImage(data: data)
            case .failure:
                self?.indicatorView.stopLoadingAnimation()
                self?.backgroundImageView.backgroundColor = UIColor.systemGray
            }
        }
    }

    func configureLabels() {
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
    }

    func configureOverviewTextView() {
        overviewTextView.text = movie.overview
        overviewTextView.sizeToFit()
    }

    func configureCollectionView() {
        collectionView.dataSource = detailViewWrapper
        collectionView.delegate = detailViewWrapper
        collectionView.register(TrailerCell.self, forCellWithReuseIdentifier: TrailerCell.identifier)
    }
}
