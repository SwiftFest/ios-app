import UIKit

var dayIndex: Int = 0

class AgendaViewController: BaseViewController {

    @IBOutlet weak var agendaTableView: UITableView!
    @IBOutlet weak var segmentedViewControl: UISegmentedControl!
    
    let agendaTableViewManager = TableViewManager(agenda: AppDataController().fetchAgenda(),
                                                  sessions: AppDataController().fetchSessions(),
                                                  speakerThumbnailUrls: AppDataController().fetchSpeakerThumbnailUrls())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Screen.Agenda.title
        agendaTableView.dataSource = agendaTableViewManager
        agendaTableView.delegate = agendaTableViewManager

    }
    
    @IBAction func changeDay(_ sender: Any) {
        
        if segmentedViewControl.selectedSegmentIndex == 0 {
         dayIndex = 0 //change dayIndex int based on which day being used
           agendaTableView.reloadData()
        }
        
        //If they Click "Day 2"
        if segmentedViewControl.selectedSegmentIndex == 1 {
           dayIndex = 1
           agendaTableView.reloadData()
        }

    }
 
}

extension AgendaViewController {

    class TableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
  
        let agenda: Agenda
        let sessions: [Session]
        let speakerThumbnailUrls: [String: String]
        
        init(agenda: Agenda,
             sessions: [Session],
             speakerThumbnailUrls: [String: String]) {
            self.agenda = agenda
            self.sessions = sessions
            self.speakerThumbnailUrls = speakerThumbnailUrls
        }
        
        private var sessionsBySection: [[Session]] {
  
            let currentDay = agenda.days[dayIndex]
            
            var sessionsBySection = [[Session]](repeating: [],
                                                count: currentDay.timeslots.count)

            for (index, timeslot) in currentDay.timeslots.enumerated() {
                let sessionsForSection = sessions.filter  { timeslot.sessionIds.contains($0.id) }
                sessionsBySection[index] = sessionsForSection
            }
        
            return sessionsBySection
        }

        func numberOfSections(in tableView: UITableView) -> Int {
            return agenda.days[dayIndex].timeslots.count ?? 0
        }
  
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let startTime = agenda.days[dayIndex].timeslots[section].startTime
            return DateFormatter.localizedString(from: startTime.date!,
                                                 dateStyle: .none,
                                                 timeStyle: .short)
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sessionsBySection[section].count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //this one returns cell
            guard !sessionsBySection.isEmpty,
                sessionsBySection.count > indexPath.section,
                !sessionsBySection[indexPath.section].isEmpty,
                sessionsBySection[indexPath.section].count > indexPath.row else {
                    return UITableViewCell()
            }
            
            let session = sessionsBySection[indexPath.section][indexPath.row]
            
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SessionCell")
            cell.textLabel?.text = session.title
            cell.textLabel?.numberOfLines = 0
            cell.detailTextLabel?.text = detailText(for: indexPath)
            
            if let imageName = speakerThumbnailUrls[session.id] {
                let speakerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
                speakerImageView.image = UIImage(named: imageName)
                speakerImageView.contentMode = .scaleAspectFill
                speakerImageView.clipsToBounds = true
                speakerImageView.layer.cornerRadius = speakerImageView.frame.height / 2
                cell.accessoryView = speakerImageView
            }
            
            return cell
        }
        
        private func detailText(for indexPath: IndexPath) -> String {
            return indexPath.row == 2 ? "Workshop" : "Track \(indexPath.row + 1)"
        }

    }
}
