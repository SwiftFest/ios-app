import UIKit
import WebKit

class CodeOfConductViewController: UIViewController {
    
    @IBOutlet weak var codeOfConductWebView: WKWebView!
    
    private let codeOfConductURL = URL(string: "http://swiftfest.io/code-of-conduct/")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeOfConductWebView.accessibilityIdentifier = "codeOfConductWebview"
        loadCodeOfConduct()
    }

}

extension CodeOfConductViewController: WKUIDelegate {
    
    func loadCodeOfConduct() {
        let urlRequest = URLRequest(url: codeOfConductURL)
        codeOfConductWebView.load(urlRequest)
    }
    
}
