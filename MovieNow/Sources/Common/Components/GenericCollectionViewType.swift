import UIKit

protocol GenericCollectionViewType {
    func createCollectionViewLayout() -> UICollectionViewLayout
    func createTitleLabel() -> UILabel
    func configureCollectionView(_ collectionView: UICollectionView)
}
