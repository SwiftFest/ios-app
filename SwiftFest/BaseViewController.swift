import UIGradient
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGradientTitleView()
    }

    func loadGradientTitleView() {
        guard let frame = navigationController?.navigationBar.frame else { return }
        
        let gradientColors: [UIColor] = [UIColor(red: 255/255, green: 97/255, blue: 75/255, alpha: 1.0), UIColor(red: 255/255, green: 110/255, blue: 78/255, alpha: 1.0), UIColor(red: 255/255, green: 123/255, blue: 80/255, alpha: 1.0), UIColor(red: 254/255, green: 137/255, blue: 84/255, alpha: 1.0), UIColor(red: 253/255, green: 150/255, blue: 85/255, alpha: 1.0), UIColor(red: 254/255, green: 163/255, blue: 89/255, alpha: 1.0), UIColor(red: 252/255, green: 171/255, blue: 89/255, alpha: 1.0)]
        
        let gradientImage = UIImage.fromGradientWithDirection(.leftToRight, frame: frame, colors: gradientColors)
        
        navigationController?.navigationBar.setBackgroundImage(gradientImage, for: .default)
    }
}
