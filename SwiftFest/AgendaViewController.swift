import UIKit

class AgendaViewController: UIViewController {
    
    @IBOutlet weak var codeOfConductButton: UIBarButtonItem!
    @IBOutlet weak var agendaTableView: UITableView!
    
    let agendaTableViewManager: UITableViewDelegate & UITableViewDataSource = TableViewManager(agenda: Agenda(days: []),
                                                                                               sessions: [])
    
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
        
        let agenda: Agenda
        let sessions: [Session]
        
        private var sessionsBySection: [[Session]] {
            var sessionsBySection = [[Session]](repeating: [],
                                                count: timeBlocks.count)

            guard let dayOne = agenda.days.first else { return sessionsBySection }
            
            let sortedTimeslots = dayOne.timeslots.sorted { lhs, rhs in
                lhs.startTime.hour! < rhs.startTime.hour!
            }
            
            assert(sortedTimeslots[1].sessionIds.count == dayOne.timeslots[1].sessionIds.count)
            
            for (index, timeslot) in sortedTimeslots.enumerated() {
                let sessions = self.sessions.filter { timeslot.sessionIds.contains($0.id!) }
                sessionsBySection[index].append(contentsOf: sessions)
            }
            
            return sessionsBySection
        }

        private var timeBlocks: [Int] {
            var timeBlocks = Set<Int>()

            guard let dayOne = agenda.days.first else { return [] }

            for timeslot in dayOne.timeslots {
                timeBlocks.insert(timeslot.startTime.hour!)
            }
            return timeBlocks.sorted()
        }
        
        init(agenda: Agenda, sessions: [Session]) {
            self.agenda = agenda
            self.sessions = sessions
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return agenda.days.first?.timeslots.count ?? 0
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
            guard !sessionsBySection.isEmpty,
                sessionsBySection.count >= indexPath.section,
                !sessionsBySection[indexPath.section].isEmpty,
                sessionsBySection[indexPath.section].count >= indexPath.row else {
                    return UITableViewCell()
            }

            let session = sessionsBySection[indexPath.section][indexPath.row]
            
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SessionCell")
            cell.textLabel?.text = session.title
//            cell.detailTextLabel?.text = "\(session.speaker.firstName) \(session.speaker.lastName)"
            
            return UITableViewCell()
        }
    }
}
