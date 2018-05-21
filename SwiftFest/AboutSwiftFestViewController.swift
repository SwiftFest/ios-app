import SnapKit
import UIKit

class AboutSwiftFestViewController: UIViewController {

    @IBOutlet weak var logoContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogoView()
    }

    func setupLogoView() {
        let logoView: SwiftLogoView = .fromNib()
        logoContainerView.addSubview(logoView)
        logoView.snp.makeConstraints { (make) -> Void in
        make.top.equalTo(logoContainerView)
        make.left.equalTo(logoContainerView)
        make.right.equalTo(logoContainerView)
        make.bottom.equalTo(logoContainerView)
        }
        logoView.setup(containerViewFrame: logoContainerView.frame)
    }
}
