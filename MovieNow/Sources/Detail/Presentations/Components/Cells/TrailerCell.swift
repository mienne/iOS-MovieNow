import UIKit

class TrailerCell: UICollectionViewCell {
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()

    static let identifier = "TrailerCell"

    enum Metric {
        static let indicatorView: CGFloat = 30
        static let itemWidth = UIScreen.main.bounds.width
        static let itemHeight = floor(itemWidth * 2 / 3)
        static let itemSize = CGSize(width: itemWidth, height: itemHeight)
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

// MARK: - Public

extension TrailerCell {
    func setUp(path: String) {
        indicatorView.startLoadingAnimation()

        ImageLoader.shared.load(DetailAPISetting.youbuteThumbnail(path: path)) { [weak self] result in
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

private extension TrailerCell {
    func configureLayout() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(indicatorView)

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
