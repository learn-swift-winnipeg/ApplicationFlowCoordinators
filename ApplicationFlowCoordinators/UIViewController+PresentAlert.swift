import UIKit

extension UIViewController {
    func presentOKAlert(title: String, message: String) {
        let alertViewController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true)
    }
}
