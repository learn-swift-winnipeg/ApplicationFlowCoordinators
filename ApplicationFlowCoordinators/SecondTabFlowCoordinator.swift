import UIKit

class SecondTabFlowCoordinator: FlowCoordinator {
    
    // MARK: - Stored Properties
    
    private let navigationController: UINavigationController
    
    // MARK: - Lifecycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - FlowCoordinator
    
    func start() {
        let secondTabVC = SecondTabVC()
        secondTabVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        
        self.navigationController.pushViewController(secondTabVC, animated: false)
    }
}
