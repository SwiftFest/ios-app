import UIKit

@IBDesignable
class GradientView: UIView {

    var colors: [UIColor] = [] {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        colors = [UIColor.red.withAlphaComponent(0.2), UIColor.blue.withAlphaComponent(0.2)]
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }

}
