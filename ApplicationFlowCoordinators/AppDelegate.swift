import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Stored Properties
    
    var window: UIWindow?
    var appFlowCoordinator: AppFlowCoordinator?

    // MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let rootViewController = UIViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        appFlowCoordinator = AppFlowCoordinator(
            rootViewController: rootViewController,
            userAccountService: UserAccountController()
        )
        appFlowCoordinator?.start()
        
        return true
    }
}
