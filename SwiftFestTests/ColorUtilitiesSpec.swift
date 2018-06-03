import Nimble
import Quick
@testable import SwiftFest

class ColorUtilitiesSpec: QuickSpec {
    override func spec() {
        describe("color hex strings") {
            it("can be parsed into colors") {
                expect(UIColor(hexString: "#FF0000")).to(equal(UIColor.red))
                expect(UIColor(hexString: "#00FF00")).to(equal(UIColor.green))
                expect(UIColor(hexString: "#0000FF")).to(equal(UIColor.blue))
                let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1) // using RGB constructor to match color space
                expect(UIColor(hexString: "#000000")).to(equal(black))
                let white = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
                expect(UIColor(hexString: "#FFFFFF")).to(equal(white))
            }
        }
    }
}
