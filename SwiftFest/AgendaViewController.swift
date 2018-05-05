import UIKit

class AgendaViewController: UIViewController {
    
    @IBOutlet weak var codeOfConductButton: UIBarButtonItem!
    @IBOutlet weak var agendaTableView: UITableView!
    
    let agendaTableViewManager: UITableViewDelegate & UITableViewDataSource = TableViewManager(agenda: AppDataController().fetchAgenda(),
                                                                                               sessions: AppDataController().fetchSessions())
    
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
            
            guard let dayOne = agenda.days.first else {
                return [[]]
            }
            
            var sessionsBySection = [[Session]](repeating: [],
                                                count: dayOne.timeslots.count)

            for (index, timeslot) in dayOne.timeslots.enumerated() {
                let sessionsForSection = sessions.filter { timeslot.sessionIds.contains($0.id!) }
                sessionsBySection[index] = sessionsForSection
            }
        
            return sessionsBySection
        }
        
        init(agenda: Agenda, sessions: [Session]) {
            self.agenda = agenda
            self.sessions = sessions
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return agenda.days.first?.timeslots.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let startTime = agenda.days.first!.timeslots[section].startTime
            return DateFormatter.localizedString(from: startTime.date!,
                                                 dateStyle: .none,
                                                 timeStyle: .short)
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sessionsBySection[section].count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard !sessionsBySection.isEmpty,
                sessionsBySection.count > indexPath.section,
                !sessionsBySection[indexPath.section].isEmpty,
                sessionsBySection[indexPath.section].count > indexPath.row else {
                    return UITableViewCell()
            }

            let session = sessionsBySection[indexPath.section][indexPath.row]
            
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SessionCell")
            cell.textLabel?.text = session.title
            
            return cell
        }
    }
}
