import BonMot
#if DEBUG
    import SimulatorStatusMagic
#endif
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().barTintColor = Color.black.color
        UINavigationBar.appearance().titleTextAttributes = StringStyle(.color(Color.white.color)).attributes
        UINavigationBar.appearance().isTranslucent = false
        UIBarButtonItem.appearance().tintColor = Color.white.color
        UITabBar.appearance().isTranslucent = false

        #if DEBUG
        if UserDefaults.standard.bool(forKey: "FASTLANE_SNAPSHOT") {
            SDStatusBarManager.sharedInstance().enableOverrides()
        }
        #endif

        return true
    }
}
