import UIKit

// MARK: -
protocol UserAccountTabVCDelegate: class {
    func didTapUpdatePassword(from userAccountTabVC: UserAccountTabVC)
    func didTapSignOut(from userAccountTabVC: UserAccountTabVC)
}

// MARK: -
class UserAccountTabVC: UIViewController {
    
    // MARK: - Stored Properties
    
    weak var delegate: UserAccountTabVCDelegate?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "User Account Preferences"
    }
    
    // MARK: - Actions
    
    @IBAction func updatePasswordTapped(_ sender: Any) {
        delegate?.didTapUpdatePassword(from: self)
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        delegate?.didTapSignOut(from: self)
    }
}
