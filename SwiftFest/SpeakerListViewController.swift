import UIKit

class SpeakerListViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var speakerListTableView: UITableView!
    private var selectedSpeaker: Speaker?

    var speakers: [Speaker] = [] {
        didSet {
            speakerListTableView.reloadData()
        }
    }
    
    var sessionTitles = [String]() {
        didSet {
            speakerListTableView.reloadData()
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        speakers = AppDataController.shared.speakers
        sessionTitles = speakers.map { AppDataController.shared.session(forSpeaker: $0.id)?.title ?? "Master of Ceremony" }
        
        speakerListTableView.delegate = self
        speakerListTableView.dataSource = self
        
        speakerListTableView.register(UINib(nibName: "RibbonTableViewCell", bundle: nil), forCellReuseIdentifier: "SpeakerListTableViewCell")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let speakerDetailViewController = segue.destination as? SpeakerDetailViewController {
            speakerDetailViewController.detailType = SpeakerDetailViewController.DetailType(selectedSpeaker!)
            speakerDetailViewController.transitioningDelegate = self
        }
    }

}

extension SpeakerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speakers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpeakerListTableViewCell", for: indexPath) as! RibbonTableViewCell
        
        cell.mainTextLabel.text = speakers[indexPath.row].name
        cell.mainTextLabel.textColor = Color.black.color
        cell.mainTextLabel.font = UIFont.boldSystemFont(ofSize: UIFontMetrics.default.scaledValue(for: 18))
        
        cell.secondaryTextLabel.text = sessionTitles[indexPath.row]
        
        cell.secondaryTextLabel.font = UIFont.systemFont(ofSize: UIFontMetrics.default.scaledValue(for: 12))
        cell.secondaryTextLabel.textColor = Color.mediumGray.color
        cell.secondaryTextLabel.numberOfLines = 0
        cell.secondaryTextLabel.lineBreakMode = .byWordWrapping

        cell.tertiaryTextLabel.text = ""
        
        let imageName = speakers[indexPath.row].thumbnailUrl
        cell.multiImageView.images = [UIImage(named: imageName)].compactMap { $0 }

        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSpeaker = speakers[indexPath.row]
        self.performSegue(withIdentifier: "SpeakerDetailSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
