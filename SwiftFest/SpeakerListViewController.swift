import UIKit

class SpeakerListViewController: BaseViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var speakerListTableView: UITableView!
    private var selectedSpeaker: Speaker?

    var speakers: [Speaker] = [] {
        didSet {
            speakerListTableView.reloadData()
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        speakers = AppDataController().fetchSpeakers()
        speakerListTableView.delegate = self
        speakerListTableView.dataSource = self
    }
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let speakerDetailViewController = segue.destination as? SpeakerDetailViewController {
            speakerDetailViewController.speaker = selectedSpeaker!
            speakerDetailViewController.transitioningDelegate = self
            speakerDetailViewController.detailType = .speakerInfo
        }
    }

}

extension SpeakerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speakers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = self.speakerListTableView.dequeueReusableCell(withIdentifier: "SpeakerListTableViewCell") as! SpeakerListTableViewCell
        cell.speakerSession =  AppDataController().speakerSessionForSpeaker(speakers[indexPath.row])
        cell.updateUI()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSpeaker = speakers[indexPath.row]
        self.performSegue(withIdentifier: "SpeakerDetailSegue", sender: nil)
    }
}
