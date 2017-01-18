import UIKit

// MARK: -
protocol UserAccountTabFlowCoordinatorDelegate: class {
    func didTapSignOut(from userAccountTabFlowCoordinator: UserAccountTabFlowCoordinator)
}

// MARK: -
class UserAccountTabFlowCoordinator: FlowCoordinator {
    
    // MARK: - Stored Properties
    
    fileprivate let navigationController: UINavigationController
    fileprivate weak var delegate: UserAccountTabFlowCoordinatorDelegate?
    
    // MARK: - Services
    
    fileprivate let userAccountService: UserAccountService
    
    // MARK: - Lifecycle
    
    init(
        navigationController: UINavigationController,
        userAccountService: UserAccountService,
        delegate: UserAccountTabFlowCoordinatorDelegate)
    {
        self.navigationController = navigationController
        self.userAccountService = userAccountService
        self.delegate = delegate
    }
    
    // MARK: - FlowCoordinator
    
    func start() {
        let userAccountTabVC = UserAccountTabVC()
        userAccountTabVC.delegate = self
        userAccountTabVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        self.navigationController.pushViewController(userAccountTabVC, animated: false)
    }
    
    // MARK: - Navigation
    
    fileprivate func showUpdatePassword() {
        let updatePasswordVC = UpdatePasswordVC()
        updatePasswordVC.delegate = self
        
        let backItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationController.topViewController?.navigationItem.backBarButtonItem = backItem
        
        navigationController.pushViewController(updatePasswordVC, animated: true)
    }
}

// MARK: - UserAccountTabVCDelegate
extension UserAccountTabFlowCoordinator: UserAccountTabVCDelegate {
    func didTapUpdatePassword(from userAccountTabVC: UserAccountTabVC) {
        // Move to next screen in flow.
        showUpdatePassword()
    }
    
    func didTapSignOut(from userAccountTabVC: UserAccountTabVC) {
        // Notify delegate
        delegate?.didTapSignOut(from: self)
    }
}

// MARK: - UpdatePasswordVCDelegate
extension UserAccountTabFlowCoordinator: UpdatePasswordVCDelegate {
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
        
        // Pop VC from nav stack.
        navigationController.popViewController(animated: true)
    }
}
