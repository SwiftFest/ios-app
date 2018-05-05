import UIKit

class AgendaViewController: UIViewController {
    
    @IBOutlet weak var codeOfConductButton: UIBarButtonItem!
    @IBOutlet weak var agendaTableView: UITableView!
    
    let agendaTableViewManager: UITableViewDelegate & UITableViewDataSource = TableViewManager(with: AppDataController().allSpeakerSessions)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Screen.Agenda.title
        agendaTableView.dataSource = agendaTableViewManager
        agendaTableView.delegate = agendaTableViewManager
        codeOfConductButton.accessibilityIdentifier = "codeOfConductButton"
    }
}

extension AgendaViewController {
    
    class TableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
        
        let sessions: [SpeakerSession]
        
        private var sessionsBySection: [[SpeakerSession]] {
            var sessionsBySection = [[SpeakerSession]](repeating: [],
                                                       count: timeBlocks.count)
            
            let sortedSessions = sessions.sorted {
                $0.session!.date!.hour! < $1.session!.date!.hour!
            }
            
            for session in sortedSessions {
                let section = timeBlocks.index { $0 == session.session!.date!.hour }!
                sessionsBySection[section].append(session)
            }
            
            return sessionsBySection
        }
        
        private var timeBlocks: [Int] {
            var timeBlocks = Set<Int>()
            for session in sessions {
                timeBlocks.insert(session.session!.date!.hour!)
            }
            return timeBlocks.sorted()
        }
        
        init(with sessions: [SpeakerSession] = []) {
            self.sessions = sessions
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return timeBlocks.count
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let hour = timeBlocks[section] > 12 ? timeBlocks[section] - 12 : timeBlocks[section]
            let period = timeBlocks[section] >= 12 ? "PM" : "AM"
            return "\(hour):00 \(period)"
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sessionsBySection[section].count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let session = sessionsBySection[indexPath.section][indexPath.row]
            
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SessionCell")
            cell.textLabel?.text = session.session?.title
            cell.detailTextLabel?.text = "\(session.speaker.firstName) \(session.speaker.lastName)"
            
            return cell
        }
    }
}
