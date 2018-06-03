import UIKit

// swiftlint:disable colon
extension UIColor {

    convenience init(hexString: String) {
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 1 // bypass '#' character
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        self.init(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 08) / 255.0,
            blue:  CGFloat((rgbValue & 0x0000FF) >> 00) / 255.0,
            alpha: 1
        )
    }

}
