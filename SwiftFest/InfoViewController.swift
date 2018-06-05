import BonMot
import SafariServices
import UIKit

class InfoViewController: BaseViewController {

    private let items = [
        Item(title: "Code of Conduct", url: URL(string: "http://swiftfest.io/code-of-conduct/")!),
        Item(title: "Twitter", url: URL(string: "https://twitter.com/theswiftfest")!),
        Item(title: "Website", url: URL(string: "http://swiftfest.io")!),
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // header view

        let logo = Asset.logo
        let headerView = UIImageView(image: UIImage(asset: logo))
        headerView.contentMode = .scaleAspectFit
        let originalSize = logo.image.size
        let scale: CGFloat = 3.0
        let scaledSize = CGSize(width: originalSize.width * scale, height: originalSize.height * scale)
        headerView.frame = CGRect(origin: .zero, size: scaledSize)
        tableView.tableHeaderView = headerView

        // footer view
        let footer = UILabel()
        footer.numberOfLines = 0
        let style = StringStyle(
            .alignment(.center),
            .font(.preferredFont(forTextStyle: .callout))
            )

        let footerText = [
            "SwiftFest 2018".styled(with: style.byAdding(.color(Color.darkOrange.color), .emphasis(.bold))),
            "Proudly made in Boston".styled(with: style),
        ].joined(separator: "\n")
        footer.attributedText = footerText
        footer.sizeToFit()
        tableView.tableFooterView = footer
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "InfoCell")
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        present(browser(for: items[indexPath.row].url), animated: true, completion: nil)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension InfoViewController {

    struct Item {
        let title: String
        let url: URL
    }

    func browser(for url: URL) -> SFSafariViewController {
        let safariBrowser = SFSafariViewController(url: url)
        safariBrowser.preferredBarTintColor = .black
        safariBrowser.preferredControlTintColor = Color.white.color
        return safariBrowser
    }
}
