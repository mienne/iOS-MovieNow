import UIKit

extension UIViewController {
    func addChildViewController(_ child: UIViewController, containerView: UIView? = nil, constraints: [NSLayoutConstraint]) {
        willMove(toParent: self)
        addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        if let containerView = containerView {
            containerView.addSubview(child.view)
        } else {
            view.addSubview(child.view)
        }
        NSLayoutConstraint.activate(constraints)
        child.didMove(toParent: self)
    }

    func removeChildViewController(_ child: UIViewController) {
        if child.parent == nil { return }
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
