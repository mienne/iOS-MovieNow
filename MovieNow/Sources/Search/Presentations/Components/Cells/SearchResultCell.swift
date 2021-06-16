import UIKit

class SearchResultCell: UITableViewCell {
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()

    private lazy var averageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 1
        return label
    }()

    static let identifier = "SearchResultCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }
}

// MARK: - Override

extension SearchResultCell {
    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
        averageLabel.text = nil
        posterImageView.image = nil
        indicatorView.stopLoadingAnimation()
    }
}

// MARK: - Public

extension SearchResultCell {
    func setUp(_ movie: MoviePresentable) {
        titleLabel.text = movie.title
        averageLabel.text = movie.voteAverage
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

private extension SearchResultCell {
    func configureLayout() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(indicatorView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(averageLabel)

        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            posterImageView.widthAnchor.constraint(equalToConstant: 72),
            indicatorView.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 30),
            indicatorView.widthAnchor.constraint(equalToConstant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            averageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            averageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            averageLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
}
