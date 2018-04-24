import UIKit

class SpeakerListViewController: UIViewController {

    @IBOutlet weak var speakerListTableView: UITableView!
    
    var speakers: [Speaker] = [] {
        didSet {
            speakerListTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSpeakersFromStaticJSON()
        // Do any additional setup after loading the view.
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
        print("there will be segues")
    }

}
