import UIKit

extension UIStoryboard {
    static func viewController<T: BaseViewController>(_: T.Type, at name: String? = nil) -> T {
        let identifier = String(describing: T.self)
        let storyboardName = name ?? identifier
        guard let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError()
        }

        return viewController
    }
}
