import UIKit

// MARK: -
class AppFlowCoordinator: FlowCoordinator {
    
    // MARK: - Stored Properties
    
    fileprivate let rootViewController: UIViewController
    private var userAccountService: UserAccountService
    
    // MARK: Child Coordinators
    
    fileprivate var authFlowCoordinator: AuthFlowCoordinator?
    fileprivate var mainTabBarFlowCoordinator: MainTabBarFlowCoordinator?
    
    // MARK: - Lifecycle
    
    init(rootViewController: UIViewController, userAccountService: UserAccountService) {
        self.rootViewController = rootViewController
        self.userAccountService = userAccountService
    }
    
    // MARK: - FlowCoordinator
    
    func start() {
        // Setup first view conditionally depending on whether user is signed in.
        if userAccountService.isSignedIn {
            showMainTabBarFlow()
        } else {
            showAuthenticationFlow(animated: false)
        }
    }
    
    // MARK: - Navigation
    
    fileprivate func showMainTabBarFlow() {
        let mainTabBarController = MainTabBarController()
        
        mainTabBarFlowCoordinator = MainTabBarFlowCoordinator(
            mainTabBarController: mainTabBarController,
            delegate: self,
            userAccountService: userAccountService
        )
        mainTabBarFlowCoordinator?.start()
        
        transition(to: mainTabBarController)
    }
    
    fileprivate func showAuthenticationFlow(animated: Bool, completion: (() -> Void)? = nil) {
        let navController = UINavigationController()
        
        authFlowCoordinator = AuthFlowCoordinator(
            navigationController: navController,
            delegate: self,
            userAccountService: userAccountService
        )
        authFlowCoordinator?.start()
        
        rootViewController.present(navController, animated: animated, completion: completion)
    }
    
    // MARK: ViewController Transitions
    
    fileprivate var currentChildVC: UIViewController? {
        willSet {
            guard newValue == nil else { return }
            currentChildVC?.view.removeFromSuperview()
            currentChildVC?.removeFromParentViewController()
        }
    }
    
    private func transition(to toVC: UIViewController) {
        let fromVC = currentChildVC
        fromVC?.willMove(toParentViewController: nil)
        
        rootViewController.addChildViewController(toVC)
        toVC.view.frame = rootViewController.view.frame
        rootViewController.view.addSubview(toVC.view)
        
        toVC.didMove(toParentViewController: rootViewController)
        fromVC?.view.removeFromSuperview()
        fromVC?.removeFromParentViewController()
        
        currentChildVC = toVC
    }
}

// MARK: - MainTabBarFlowCoordinatorDelegate
extension AppFlowCoordinator: MainTabBarFlowCoordinatorDelegate {
    func mainTabBarFlowCoordinatorDidSignOut(mainTabBarFlowCoordinator: MainTabBarFlowCoordinator) {
        // Show Authentication flow
        self.showAuthenticationFlow(animated: true) {
            self.mainTabBarFlowCoordinator = nil
            self.currentChildVC = nil
        }
    }
}

// MARK: - AuthFlowCoordinatorDelegate
extension AppFlowCoordinator: AuthFlowCoordinatorDelegate {
    func didSuccessfullyAuthenticate(from authCoordinator: AuthFlowCoordinator) {
        // Switch to MainTabBar while auth modal is still on top.
        self.showMainTabBarFlow()
        
        // Dismiss to reveal the MainTabBar.
        self.rootViewController.dismiss(animated: true) {
            self.authFlowCoordinator = nil
        }
    }
}
