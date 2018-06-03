import SafariServices
import UIKit

class InfoViewController: BaseViewController {

    let infoItems = ["Code of Conduct", "About SwiftFest", "Twitter", "Website"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
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
            present(browser(for: .codeOfConduct), animated: true, completion: nil)
        case "About SwiftFest":
            performSegue(withIdentifier: "AboutSwiftFestSegue", sender: self)
        case "Twitter":
            present(browser(for: .twitter), animated: true, completion: nil)
        case "Website":
            present(browser(for: .website), animated: true, completion: nil)
        default:
            fatalError("this was not the case you were looking for")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension InfoViewController {
    
    enum URLs: String {
        case codeOfConduct = "http://swiftfest.io/code-of-conduct/"
        case twitter = "https://twitter.com/theswiftfest"
        case website = "http://swiftfest.io"
    }
    
    func browser(for url: URLs) -> SFSafariViewController {
        let safariBrowser = SFSafariViewController(url: URL(string: url.rawValue)!)
        safariBrowser.preferredBarTintColor = .black
        safariBrowser.preferredControlTintColor = Color.white.color
        return safariBrowser
    }
}
