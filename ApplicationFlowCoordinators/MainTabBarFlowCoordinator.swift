import UIKit

protocol MainTabBarFlowCoordinatorDelegate: class {
    func mainTabBarFlowCoordinatorDidSignOut(mainTabBarFlowCoordinator: MainTabBarFlowCoordinator)
}

class MainTabBarFlowCoordinator: FlowCoordinator {
    
    // MARK: - Stored Properties
    
    weak var delegate: MainTabBarFlowCoordinatorDelegate?
    private let mainTabBarController: MainTabBarController
    private var firstTabFlowCoordinator: FirstTabFlowCoordinator?
    private var secondTabFlowCoordinator: SecondTabFlowCoordinator?
    private var userAccountTabFlowCoordinator: UserAccountTabFlowCoordinator?
    
    // MARK: Services
    
    fileprivate var userAccountService: UserAccountService
    
    // MARK: - Lifecycle
    
    init(
        mainTabBarController: MainTabBarController,
        delegate: MainTabBarFlowCoordinatorDelegate,
        userAccountService: UserAccountService)
    {
        self.delegate = delegate
        self.mainTabBarController = mainTabBarController
        self.userAccountService = userAccountService
    }
    
    // MARK: - FlowCoordinator
    
    func start() {
        // Setup view controllers and additional FlowControllers for each tab
        
        // First tab
        let firstNavController = UINavigationController()
        firstTabFlowCoordinator = FirstTabFlowCoordinator(navigationController: firstNavController)
        firstTabFlowCoordinator?.start()
        
        // Second tab
        let secondNavController = UINavigationController()
        secondTabFlowCoordinator = SecondTabFlowCoordinator(navigationController: secondNavController)
        secondTabFlowCoordinator?.start()
        
        // User Account tab
        let userAccountNavController = UINavigationController()
        userAccountTabFlowCoordinator = UserAccountTabFlowCoordinator(
            navigationController: userAccountNavController,
            userAccountService: userAccountService,
            delegate: self
        )
        userAccountTabFlowCoordinator?.start()
        
        // Add tabs to mainTabBarController
        mainTabBarController.viewControllers = [firstNavController, secondNavController, userAccountNavController]
    }
}

extension MainTabBarFlowCoordinator: UserAccountTabFlowCoordinatorDelegate {
    func didTapSignOut(from userAccountTabFlowCoordinator: UserAccountTabFlowCoordinator) {
        delegate?.mainTabBarFlowCoordinatorDidSignOut(mainTabBarFlowCoordinator: self)
    }
}
