import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(updateConnection(_:)), name: .isConnected, object: nil)
        NetworkChecker.shared.start()

        configureTabBar()
        configureViewControllers()
    }

    deinit {
        NetworkChecker.shared.cancel()
    }
}

// MARK: - Private

private extension MainTabBarController {
    func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .label
        appearance.stackedLayoutAppearance.normal.iconColor = .label
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        appearance.stackedLayoutAppearance.selected.iconColor = .systemRed
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed]
        tabBar.standardAppearance = appearance
    }

    func configureViewControllers() {
        viewControllers?.forEach { setupViewControllerType($0) }
    }

    func setupViewControllerType(_ viewController: UIViewController) {
        viewController.children.forEach {
            if let viewController = $0 as? MovieViewControllerType {
                let viewModel = MovieViewModel(DefaultMovieUseCase(DefaultMovieRepository()))
                viewController.configureViewModel(viewModel)
            } else if let viewController = $0 as? TVViewControllerType {
                let viewModel = TVViewModel(DefaultTVUseCase(DefaultTVRepository()))
                viewController.configureViewModel(viewModel)
            } else if let viewController = $0 as? SearchViewControllerType {
                let viewModel = SearchViewModel(
                    useCase: DefaultSearchUseCase(DefaultSearchRepository()),
                    worker: SearchWorker(interval: 0.5, repeats: false)
                )
                viewController.configureViewModel(viewModel)
            }
        }
    }

    @objc func updateConnection(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let isConnected = userInfo["isConnected"] as? Bool,
              !isConnected
        else {
            return
        }

        DispatchQueue.main.async {
            self.showConnectionAlert()
        }
    }
}
