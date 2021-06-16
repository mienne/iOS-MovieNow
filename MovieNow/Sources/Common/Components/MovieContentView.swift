import UIKit

class MovieContentView: UIView {
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()

    enum Metric {
        static let itemWidth = floor((UIScreen.main.bounds.width / 4) - 10)
        static let itemHeight = floor(itemWidth * 3 / 2)
        static let itemSize = CGSize(width: itemWidth, height: itemHeight)
        static let indicatorView: CGFloat = 30
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }
}

// MARK: - Public: Configure UI

extension MovieContentView {
    func setup(_ movie: MoviePresentable) {
        indicatorView.startLoadingAnimation()

        ImageLoader.shared.load(ImageLoaderSetting.trending(size: .w154, path: movie.posterPath)) { [weak self] result in
            switch result {
            case let .success(data):
                self?.posterImageView.image = UIImage(data: data)
                self?.indicatorView.stopLoadingAnimation()
            case .failure:
                self?.indicatorView.stopLoadingAnimation()
            }
        }
    }
}

// MARK: - Private

private extension MovieContentView {
    func configureLayout() {
        addSubview(posterImageView)
        addSubview(indicatorView)

        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: Metric.indicatorView),
            indicatorView.widthAnchor.constraint(equalToConstant: Metric.indicatorView)
        ])
    }
}
