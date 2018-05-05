import UIKit

struct LocalSession {
    let title: String
    let presenter: String
    let time: DateComponents
    init(titled title: String, presentedBy presenter: String, at time: DateComponents) {
        self.title = title
        self.presenter = presenter
        self.time = time
    }
}

class AgendaViewController: UIViewController {

    @IBOutlet weak var codeOfConductButton: UIBarButtonItem!
    
    let agendaTableViewManager: UITableViewDelegate & UITableViewDataSource = TableViewManager(with: [
            LocalSession(titled: "Session Name 1",
                    presentedBy: "Speaker 1",
                    at: DateComponents(hour: 9)),
            LocalSession(titled: "Session Name 2",
                    presentedBy: "Speaker 2",
                    at: DateComponents(hour: 10)),
            LocalSession(titled: "Session Name 3",
                    presentedBy: "Speaker 3",
                    at: DateComponents(hour: 11)),
            LocalSession(titled: "Session Name 4",
                    presentedBy: "Speaker 4",
                    at: DateComponents(hour: 11)),
            LocalSession(titled: "Session Name 5",
                    presentedBy: "Speaker 5",
                    at: DateComponents(hour: 13))
        ])

    @IBOutlet weak var agendaTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Screen.Agenda.title
        agendaTableView.dataSource = agendaTableViewManager
        agendaTableView.delegate = agendaTableViewManager
        uiSetup()
    }
    
    func uiSetup() {
        codeOfConductButton.accessibilityIdentifier = "codeOfConductButton"
    }
    
}

extension AgendaViewController {

    class TableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {

        let sessions: [LocalSession]

        private var sessionsBySection: [[LocalSession]] {
            var sessionsBySection = [[LocalSession]](repeating: [],
                                                count: timeBlocks.count)

            let sortedSessions = sessions.sorted {
                $0.time.hour! < $1.time.hour!
            }

            for session in sortedSessions {
                let section = timeBlocks.index { $0 == session.time.hour }!
                sessionsBySection[section].append(session)
            }

            return sessionsBySection
        }

        private var timeBlocks: [Int] {
            var timeBlocks = Set<Int>()
            for session in sessions {
                timeBlocks.insert(session.time.hour!)
            }
            return timeBlocks.sorted()
        }

        init(with sessions: [LocalSession] = []) {
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
            cell.textLabel?.text = session.title
            cell.detailTextLabel?.text = session.presenter

            return cell
        }
    }
}
