import UIKit
import ReactNativeBinaryExampleKit
import ReactNativeBinaryExampleUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        ReactNativeBinaryExampleKit.hello()
        ReactNativeBinaryExampleUI.hello()

        return true
    }

}
