import UIKit

class SponsorsViewController: BaseViewController {

    var sponsors: [Sponsor] = []
    @IBOutlet weak var acknowledgementLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SponsorLogoTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "logoCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none

        NotificationCenter.default.addObserver(self, selector: #selector(newDataAvailable), name: AppDataController.Notifications.dataDidUpdate, object: nil)
        
        updateData()
    }

}

// MARK: - Notifications
private extension SponsorsViewController {
    
    @objc func newDataAvailable(_ notification: Notification) {
        updateData()
    }
    
}

// MARK: - Private
private extension SponsorsViewController {
    
    func updateData() {
        guard let results = AppDataController.shared.sponsors else { return }
        
        sponsors = results.flatMap { $0.elements }.shuffled()
        tableView.reloadData()
    }
    
}

extension SponsorsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < sponsors.count else { return }
        
        let sponsor = sponsors[indexPath.row]
        
        guard let url = URL(string: sponsor.link),
              UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension SponsorsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sponsors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < sponsors.count else { return UITableViewCell() }
        
        let sponsor = sponsors[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "logoCell") as? SponsorLogoTableViewCell else { return UITableViewCell() }
        
        cell.logoImageView.accessibilityLabel = sponsor.name
        cell.logoImageView.accessibilityHint = "Tap to open their website"
        APIClient.shared.loadSponsorImage(named: sponsor.imageUrl, into: cell.logoImageView, completionHandler: nil)
        
        return cell
    }
}
