import UIKit

class SponsorsViewController: BaseViewController {

    var sponsors: [Sponsor] = []
    @IBOutlet weak var acknowledgementLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        self.sponsors = results.flatMap { $0.elements }.sorted { $0.name > $1.name }
    }
    
}
