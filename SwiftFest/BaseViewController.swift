import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
    }

    func navBarSetup() {
      navigationController?.navigationBar.tintColor = .white
      navigationController?.navigationBar.barStyle = UIBarStyle.black
      navigationController?.navigationBar.barTintColor = .black
        //let barstyle = UIBarStyle(rawValue: 3)
    }
}
