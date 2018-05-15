import UIGradient
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGradientTitleView()
    }

    func loadGradientTitleView() {
        guard let frame = navigationController?.navigationBar.frame else { return }
        
        let gradientImage = UIImage.fromGradientWithDirection(.leftToRight, frame: frame, colors: UIUtilities.gradientColors)
        
        navigationController?.navigationBar.setBackgroundImage(gradientImage, for: .default)
    }
}
