import UIKit

// MARK: -
protocol AuthFlowCoordinatorDelegate: class {
    func didSuccessfullyAuthenticate(from authCoordinator: AuthFlowCoordinator)
}

// MARK: -
class AuthFlowCoordinator: FlowCoordinator {
    
    // MARK: - Stored Properties
    
    fileprivate let navigationController: UINavigationController
    fileprivate weak var delegate: AuthFlowCoordinatorDelegate?
    fileprivate var userAccountService: UserAccountService
    
    // MARK: - Lifecycle
    
    init(
        navigationController: UINavigationController,
        delegate: AuthFlowCoordinatorDelegate,
        userAccountService: UserAccountService)
    {
        self.delegate = delegate
        self.navigationController = navigationController
        self.userAccountService = userAccountService
    }
    
    // MARK: - FlowCoordinator
    
    func start() {
        let signInVC = SignInVC()
        signInVC.delegate = self
        
        navigationController.pushViewController(signInVC, animated: false)
    }
    
    // MARK: - Navigation
    
    fileprivate func showUpdatePasswordVC() {
        let updatePasswordVC = UpdatePasswordVC()
        updatePasswordVC.delegate = self
        
        updatePasswordVC.navigationItem.hidesBackButton = true
        self.navigationController.pushViewController(updatePasswordVC, animated: true)
    }
    
    fileprivate func showUpdateProfilePhotoVC() {
        let updateProfilePhotoVC = UpdateProfilePhotoVC()
        updateProfilePhotoVC.delegate = self
        
        updateProfilePhotoVC.navigationItem.hidesBackButton = true
        self.navigationController.pushViewController(updateProfilePhotoVC, animated: true)
    }
}

extension AuthFlowCoordinator: SignInVCDelegate {
    func signInVC(
        signInVC: SignInVC,
        didAttemptSignInWithEmail email: String?,
        password: String?,
        isPasswordChangeRequired: Bool)
    {
        // Validate inputs.
        guard userAccountService.validateSignInInputs(email: email, password: password) else {
            self.navigationController.presentOKAlert(title: "Oops", message: "Please enter email and password.")
            return
        }
        
        // Dismiss keyboard
        signInVC.dismissKeyboard()
        
        // Move to next screen in flow.
        if isPasswordChangeRequired {
            showUpdatePasswordVC()
        } else {
            showUpdateProfilePhotoVC()
        }
    }
}

extension AuthFlowCoordinator: UpdatePasswordVCDelegate {
    func updatePasswordVC(
        updatePasswordVC: UpdatePasswordVC,
        didAttemptPasswordUpdateWithPrevious previous: String?,
        new: String?,
        confirm: String?)
    {
        // Validate inputs.
        guard userAccountService.validatePasswordChangeInputs(previous: previous, new: new, confirm: confirm) else {
            self.navigationController.presentOKAlert(title: "Oops", message: "Please enter all the text fields.")
            return
        }
        
        // Move to next screen in flow.
        showUpdateProfilePhotoVC()
    }
}

extension AuthFlowCoordinator: UpdateProfilePhotoVCDelegate {
    func didSuccessfullyUpdateProfilePhoto(from updateProfilePhotoVC: UpdateProfilePhotoVC) {
        // Move to next screen in flow... What? There are no more screens in this flow? Then notify our delegate.
        delegate?.didSuccessfullyAuthenticate(from: self)
    }
}
