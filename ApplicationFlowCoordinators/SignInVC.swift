import UIKit

protocol SignInVCDelegate: class {
    func signInVC(signInVC: SignInVC, didAttemptSignInWithEmail: String?, password: String?, isPasswordChangeRequired: Bool)
}

class SignInVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var passwordChangeRequiredSwitch: UISwitch!
    
    // MARK: - Stored Properties
    
    weak var delegate: SignInVCDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.navigationItem.title = "Sign In"
    }
    
    // MARK: - Coordinator Helpers
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }

    // MARK: - Actions
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        delegate?.signInVC(
            signInVC: self,
            didAttemptSignInWithEmail: emailTextField.text,
            password: passwordTextField.text,
            isPasswordChangeRequired: passwordChangeRequiredSwitch.isOn
        )
    }
}

