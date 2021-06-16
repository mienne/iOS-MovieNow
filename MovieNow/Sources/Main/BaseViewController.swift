import UIKit

class BaseViewController: UIViewController {
    var isNavigationBarHidden: Bool = false
}

// MARK: - Life Cycle

extension BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: true)
    }
}

// MARK: - Private

private extension BaseViewController {
    func configureNavigationBar() {
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = .systemBackground
        standard.titleTextAttributes = [.foregroundColor: UIColor.label]
        standard.shadowColor = .label
        navigationController?.navigationBar.standardAppearance = standard
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
