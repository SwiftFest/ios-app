import SafariServices
import UIKit

class InfoViewController: BaseViewController {

    let infoItems = ["Code of Conduct", "About SwiftFest"]
    
    private let codeOfConductURL = URL(string: "http://swiftfest.io/code-of-conduct/")!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "InfoCell")
        cell.textLabel?.text = infoItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch infoItems[indexPath.row] {
        case "Code of Conduct":
            let safariBrowser = SFSafariViewController(url: codeOfConductURL)
            safariBrowser.preferredBarTintColor = .black
            safariBrowser.preferredControlTintColor = .white
            present(safariBrowser, animated: true, completion: nil)
        case "About SwiftFest":
            performSegue(withIdentifier: "AboutSwiftFestSegue", sender: self)
        default:
            print("do nothing!")
        }
    }
}
