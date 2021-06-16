import UIKit

class GenericCollectionViewController<View: UIView, Cell: GenericCollectionViewCell<View>>: UICollectionViewController {
    private let reuseIdentifier: String
    private let type: GenericCollectionViewType

    var configureView: (IndexPath, View) -> Void = { _, _ in } {
        didSet {
            collectionView?.reloadData()
        }
    }

    var didSelectView: (IndexPath, View) -> Void = { _, _ in }

    var numberOfItems: () -> Int = { 0 } {
        didSet {
            collectionView?.reloadData()
        }
    }

    // MARK: - Initializer

    init(view _: View.Type, type: GenericCollectionViewType) {
        reuseIdentifier = "cell"
        self.type = type

        super.init(collectionViewLayout: type.createCollectionViewLayout())
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.decelerationRate = .fast
        collectionView?.backgroundColor = .systemBackground
        collectionView?.register(Cell.self, forCellWithReuseIdentifier: reuseIdentifier)
        type.configureCollectionView(collectionView)
    }

    // MARK: - DataSource, Delegate

    override func numberOfSections(in _: UICollectionView) -> Int {
        1
    }

    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        numberOfItems()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }

        configureView(indexPath, cell.view)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? Cell else { return }

        didSelectView(indexPath, cell.view)
    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
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
