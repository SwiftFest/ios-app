import BonMot
import UIKit

class SpeakerListViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var speakerListTableView: UITableView!
    private var selectedSpeaker: Speaker?

    private var speakers: [Speaker] = [] {
        didSet {
            sessionTitlesBySpeaker = AppDataController.shared.sessions.reduce(into: [:], { (dictionary, session) in
                for speakerId in session.speakers {
                    dictionary[speakerId] = session.title
                }
            })
            speakerListTableView.reloadData()
        }
    }

    private var sessionTitlesBySpeaker: [Identifier<Speaker>: String] = [:]
  
    override func viewDidLoad() {
        super.viewDidLoad()

        speakerListTableView.delegate = self
        speakerListTableView.dataSource = self
        
        speakerListTableView.register(UINib(nibName: "RibbonTableViewCell", bundle: nil), forCellReuseIdentifier: "SpeakerListTableViewCell")

        NotificationCenter.default.addObserver(self, selector: #selector(newDataAvailable), name: AppDataController.Notifications.dataDidUpdate, object: nil)

        updateData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let speakerDetailViewController = segue.destination as? SpeakerDetailViewController {
            speakerDetailViewController.detailType = SpeakerDetailViewController.DetailType(selectedSpeaker!)
            speakerDetailViewController.transitioningDelegate = self
        }
    }

}

// MARK: - Notifications

private extension SpeakerListViewController {

    @objc func newDataAvailable(_ notification: Notification) {
        updateData()
    }

}

// MARK: - Private

private extension SpeakerListViewController {

    func updateData() {
        speakers = AppDataController.shared.speakers
    }

}

// MARK: - Table View Stuff

extension SpeakerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speakers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpeakerListTableViewCell", for: indexPath) as! RibbonTableViewCell

        let speaker = speakers[indexPath.row]
        cell.mainTextLabel.text = speaker.name
        cell.mainTextLabel.textColor = Color.black.color
        cell.mainTextLabel.font = UIFont.boldSystemFont(ofSize: UIFontMetrics.default.scaledValue(for: 18))

        let titleStyle = StringStyle(
            .font(UIFont.systemFont(ofSize: UIFontMetrics.default.scaledValue(for: 12))),
            .color(Color.mediumGray.color),
            .lineBreakMode(.byWordWrapping),
            .xmlRules([]) //Will force xml parsing and escaping
        )

        cell.secondaryTextLabel.numberOfLines = 0
        cell.secondaryTextLabel.attributedText = sessionTitlesBySpeaker[speaker.id]?.styled(with: titleStyle)

        cell.tertiaryTextLabel.text = ""
        
        let imageName = speakers[indexPath.row].thumbnailUrl
        cell.multiImageView.images = [UIImage(named: imageName)].compactMap { $0 }

        cell.selectionStyle = .none

        cell.ribbon.backgroundColor = Color.lightOrange.color
        
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
