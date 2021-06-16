import UIKit

enum TVCollectionViewType {
    case todayAiring
    case onAir
    case trending
    case topRated
}

// MARK: - Public: GenericCollectionViewType

extension TVCollectionViewType: GenericCollectionViewType {
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = MovieContentView.Metric.itemSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return layout
    }

    func createTitleLabel() -> UILabel {
        generateTitleLabel()
    }

    func configureCollectionView(_ collectionView: UICollectionView) {
        collectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - Private

private extension TVCollectionViewType {
    func generateTitleLabel() -> UILabel {
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
}
