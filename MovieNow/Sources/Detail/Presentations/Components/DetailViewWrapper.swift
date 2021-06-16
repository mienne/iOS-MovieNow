import UIKit

class DetailViewWrapper: NSObject {
    private weak var collectionView: UICollectionView!
    private lazy var viewController: DetailViewController? = {
        if let viewController = self.collectionView?.findViewController() as? DetailViewController {
            return viewController
        } else {
            return nil
        }
    }()

    private var presenter: VideosPresenter?

    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
    }
}

// MARK: - Public: Configure

extension DetailViewWrapper {
    func setUp(_ presenter: VideosPresenter?) {
        self.presenter = presenter
        collectionView.reloadData()
    }
}

// MARK: - System Delegate: UICollectionViewDelegate, UICollectionViewDataSource

extension DetailViewWrapper: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        presenter?.numberOfItemsInSection ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let videoKey = presenter?[at: indexPath.row]?.key,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrailerCell.identifier, for: indexPath) as? TrailerCell
        else {
            return UICollectionViewCell()
        }

        cell.setUp(path: videoKey)
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let videoKey = presenter?[at: indexPath.row]?.key {
            let youtubeUrlString = DetailAPISetting.youtubeMovie(path: videoKey).createUrlString()
            if let youtubeUrl = URL(string: youtubeUrlString), UIApplication.shared.canOpenURL(youtubeUrl) {
                UIApplication.shared.open(youtubeUrl)
            }
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }

        let cellWidth = layout.itemSize.width + layout.minimumInteritemSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidth
        var roundedIndex = round(index)
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
        } else {
            roundedIndex = ceil(index)
        }
        offset = CGPoint(x: roundedIndex * cellWidth - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}
