import BonMot
import SafariServices
import UIKit

class InfoViewController: BaseViewController {

    private let items = [
        Item(title: "Code of Conduct", link: .web(URL(string: "http://swiftfest.io/code-of-conduct/")!)),
        Item(title: "Twitter", link: .web(URL(string: "https://twitter.com/theswiftfest")!)),
        Item(title: "Website", link: .web(URL(string: "http://swiftfest.io")!)),
        Item(title: "Venue: Calderwood Pavilion", link: .map(URL(string: "https://maps.apple.com/?address=527%20Tremont%20St,%20Boston,%20MA%20%2002116,%20United%20States&auid=589327373447087292&ll=42.344498,-71.070983&lsp=9902&q=Calderwood%20Pavilion")!)),
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
        let footerLabel = UILabel()
        footerLabel.numberOfLines = 0
        let style = StringStyle(
            .alignment(.center),
            .font(.preferredFont(forTextStyle: .callout))
            )

        let lines = [
            "\n".styled(with: style),
            "SwiftFest 2019".styled(with: style.byAdding(.color(Color.darkOrange.color), .emphasis(.bold))),
            "Proudly made in Boston".styled(with: style),
        ]
        let footerText = NSAttributedString.composed(of: lines, separator: "\n")
        footerLabel.attributedText = footerText
        footerLabel.sizeToFit()

        let footerSeparator = UIView()
        footerLabel.addSubview(footerSeparator)

        footerSeparator.snp.makeConstraints { make in
            make.height.equalTo(1 / UIScreen.main.scale)
            make.top.equalTo(footerLabel.snp.top)
            make.leading.equalTo(footerLabel.snp.leading).offset(tableView.separatorInset.left)
            make.trailing.equalTo(footerLabel.snp.trailing)
        }
        footerSeparator.backgroundColor = Color.tableViewSeparator.color

        tableView.tableFooterView = footerLabel
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

        let link = items[indexPath.row].link

        switch link {
        case .web(let url):
            present(browser(for: url), animated: true, completion: nil)
        case .map(let url):
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension InfoViewController {

    enum Link {
        case web(URL)
        case map(URL)
    }

    struct Item {
        let title: String
        let link: Link
    }

    func browser(for url: URL) -> SFSafariViewController {
        let safariBrowser = SFSafariViewController(url: url)
        safariBrowser.preferredBarTintColor = .black
        safariBrowser.preferredControlTintColor = Color.white.color
        return safariBrowser
    }
}
