import UIKit

class SpeakerListViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var speakerListTableView: UITableView!
    
    var speakers: [Speaker] = [] {
        didSet {
            speakerListTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSpeakersFromStaticJSON()
        speakerListTableView.delegate = self
        speakerListTableView.dataSource = self
    }
    
    func loadSpeakersFromStaticJSON() {
        var speakersData: Data?
        
        if let path = Bundle.main.path(forResource: "SpeakerData", ofType: "json") {
            speakersData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }
        
        let decoder = JSONDecoder()
        let decodedSpeakers = try? decoder.decode(SpeakerResults.self, from: speakersData!)
        
        if let speakerResults = decodedSpeakers?.speakers {
            for speaker in speakerResults {
                speakers.append(speaker)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let cell = sender as? SpeakerListTableViewCell, let speakerDetailViewController = segue.destination as? SpeakerDetailViewController {
            guard let speakerSession = cell.speakerSession else { return }
            speakerDetailViewController.speakerSession = speakerSession
            speakerDetailViewController.transitioningDelegate = self
            
//            activityViewController.unsplashImage = cell.unsplashImage
//            if let image = cell.activityImageView.image {
//                let colors = AverageColorFromImage(image)
//                activityViewController.gradientColor = colors
//            }
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
        cell.speakerSession = SwiftFestSessions().speakerSessionForSpeaker(speakers[indexPath.row])
        cell.updateUI()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // swiftlint:disable:next force_cast
        let cell = tableView.cellForRow(at: indexPath) as! SpeakerListTableViewCell
        let scrollViewFrame = cell.scrollView.frame
        cell.scrollView.zoom(to: CGRect(x: scrollViewFrame.midX, y: 0, width: scrollViewFrame.width, height: scrollViewFrame.height), animated: true)
    }
}
