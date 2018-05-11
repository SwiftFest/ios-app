import UIKit

protocol SpeakerListTableViewCellDelegate {
    func buttonTapped(speakerSessionDetailType: SpeakerSessionDetailType)
}

class SpeakerListViewController: BaseViewController, UIViewControllerTransitioningDelegate, SpeakerListTableViewCellDelegate {
    
    @IBOutlet weak var speakerListTableView: UITableView!
    
    var speakers: [Speaker] = [] {
        didSet {
            speakerListTableView.reloadData()
        }
    }
    
    var sessions: [Session] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speakers = AppDataController().fetchSpeakers()
        speakerListTableView.delegate = self
        speakerListTableView.dataSource = self
    }
    
    func buttonTapped(speakerSessionDetailType: SpeakerSessionDetailType) {
        self.performSegue(withIdentifier: "SpeakerDetailSegue", sender: speakerSessionDetailType)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let sender = sender as? SpeakerSessionDetailType, let speakerDetailViewController = segue.destination as? SpeakerDetailViewController {
            speakerDetailViewController.speakerSession = sender.speakerSession
            speakerDetailViewController.transitioningDelegate = self
            speakerDetailViewController.detailType = sender.detailType
        }
        
        if let cell = sender as? SpeakerListTableViewCell, let speakerDetailViewController = segue.destination as? SpeakerDetailViewController {
            guard let speakerSession = cell.speakerSession else { return }
            speakerDetailViewController.speakerSession = speakerSession
            speakerDetailViewController.transitioningDelegate = self
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

        cell.speakerSession = AppDataController().speakerSessionForSpeaker(speakers[indexPath.row])
        cell.delegate = self
        cell.updateUI()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // swiftlint:disable:next force_cast
        let cell = tableView.cellForRow(at: indexPath) as! SpeakerListTableViewCell
        //let scrollViewFrame = cell.scrollView.frame
        //cell.scrollView.zoom(to: CGRect(x: scrollViewFrame.midX, y: 0, width: scrollViewFrame.width, height: scrollViewFrame.height), animated: true)
    }
}
