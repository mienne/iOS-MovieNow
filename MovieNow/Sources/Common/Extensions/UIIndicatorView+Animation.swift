import UIKit

extension UIActivityIndicatorView {
    func startLoadingAnimation() {
        alpha = 1
        startAnimating()
    }

    func stopLoadingAnimation() {
        alpha = 0
        stopAnimating()
    }
}
