import UIKit

class FirstTabFlowCoordinator: FlowCoordinator {
    
    // MARK: - Stored Properties
    
    private let navigationController: UINavigationController
    
    // MARK: - Lifecycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - FlowCoordinator
    
    func start() {
        let firstTabVC = FirstTabVC()
        firstTabVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        self.navigationController.pushViewController(firstTabVC, animated: false)
    }
}
