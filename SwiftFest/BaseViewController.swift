import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
    }

    func navBarSetup() {
      UINavigationBar.appearance().backgroundColor = Color.black.color
    }
}
