import UIKit

extension UIViewController {
    func showConnectionAlert() {
        let alert = UIAlertController(title: nil, message: "You have no network connection. Please try connecting again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
