import UIKit

protocol UpdatePasswordVCDelegate: class {
    func updatePasswordVC(updatePasswordVC: UpdatePasswordVC, didAttemptPasswordUpdateWithPrevious: String?, new: String?, confirm: String?)
}

class UpdatePasswordVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var previousPasswordTextField: UITextField!
    @IBOutlet var newPasswordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    // MARK: - Stored Properties
    
    weak var delegate: UpdatePasswordVCDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Update Password"
        
        registerForKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    
    @IBAction func changePasswordTapped(_ sender: Any) {
        delegate?.updatePasswordVC(
            updatePasswordVC: self,
            didAttemptPasswordUpdateWithPrevious: previousPasswordTextField.text,
            new: newPasswordTextField.text,
            confirm: confirmPasswordTextField.text
        )
    }
    
    // MARK: - Keyboard Notifications
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeShown(_:)),
            name: .UIKeyboardWillShow,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden(_:)),
            name: .UIKeyboardWillHide,
            object: nil
        )
    }
    
    func keyboardWillBeShown(_ sender: Notification) {
        let info: NSDictionary = sender.userInfo! as NSDictionary
        
        let value: NSValue = info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.cgRectValue.size
        scrollView.contentInset.bottom = keyboardSize.height
        scrollView.scrollIndicatorInsets.bottom = keyboardSize.height
    }
    
    func keyboardWillBeHidden(_ sender: Notification) {
        scrollView.contentInset.bottom = 0.0
        scrollView.scrollIndicatorInsets.bottom = 0.0
    }
}
