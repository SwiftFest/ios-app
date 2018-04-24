import UIKit

class SpeakerListViewController: UIViewController {

    @IBOutlet weak var speakerListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("there will be segues")
    }

}
