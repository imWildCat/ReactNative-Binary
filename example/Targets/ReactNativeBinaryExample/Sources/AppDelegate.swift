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
        let mainVC = MainViewController()
        mainVC.view.backgroundColor = .white
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        ReactNativeBinaryExampleKit.hello()
        ReactNativeBinaryExampleUI.hello()

        return true
    }

}
