import UIKit

enum MovieCollectionViewType {
    case trending
    case nowPlaying
    case upcoming
    case topRated
}

// MARK: - Public: GenericCollectionViewType

extension MovieCollectionViewType: GenericCollectionViewType {
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = MovieContentView.Metric.itemSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return layout
    }

    func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.allowsDefaultTighteningForTruncation = true
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func configureCollectionView(_ collectionView: UICollectionView) {
        collectionView.showsHorizontalScrollIndicator = false
    }
}
