import UIKit

var dayIndex: Int = 0

class AgendaViewController: BaseViewController {

    @IBOutlet weak var agendaTableView: UITableView!
    @IBOutlet weak var segmentedViewControl: UISegmentedControl!
    
    let agendaTableViewManager = TableViewManager(agenda: AppDataController().fetchAgenda(),
                                                  sessions: AppDataController().fetchSessions(),
                                                  speakerThumbnailUrls: AppDataController().fetchSpeakerThumbnailUrls(),
                                                  viewController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Screen.Agenda.title
        segmentedViewControl.backgroundColor = Color.black.color
        segmentedViewControl.tintColor = Color.white.color

        let size = CGSize(width: 1, height: UIFontMetrics.default.scaledValue(for: 29))
        let normalImage = UIImage.from(color: Color.black.color, size: size)
        let selectedImage = UIImage.from(color: Color.white.color, size: size)
        let highlightedImage = UIImage.from(color: Color.blackHighlighted.color, size: size)

        segmentedViewControl.setBackgroundImage(normalImage, for: .normal, barMetrics: .default)
        segmentedViewControl.setBackgroundImage(selectedImage, for: .selected, barMetrics: .default)
        segmentedViewControl.setBackgroundImage(highlightedImage, for: .highlighted, barMetrics: .default)

        agendaTableView.register(UINib(nibName: "\(RibbonTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "SessionCell")
        agendaTableView.dataSource = agendaTableViewManager
        agendaTableView.delegate = agendaTableViewManager
        agendaTableViewManager.viewController = self
        
    }
    
    @IBAction func changeDay(_ sender: Any) {
        
        if segmentedViewControl.selectedSegmentIndex == 0 {
            dayIndex = 0
            agendaTableView.reloadData()
        }

        if segmentedViewControl.selectedSegmentIndex == 1 {
            dayIndex = 1
            agendaTableView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToDetailView",
            let destinationController = segue.destination as? SpeakerDetailViewController {
            destinationController.detailType = .sessionInfo
            destinationController.session = agendaTableViewManager.selectedSession
        }
        
    }
    
}

extension AgendaViewController {
    
    class TableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
        
        var selectedSession: Session?
        
        let agenda: Agenda
        let sessions: [Session]
        weak var viewController: AgendaViewController?
        let speakerThumbnailUrls: [String: String]
        
        init(agenda: Agenda,
             sessions: [Session],
             speakerThumbnailUrls: [String: String],
             viewController: AgendaViewController?) {
            self.agenda = agenda
            self.sessions = sessions
            self.speakerThumbnailUrls = speakerThumbnailUrls
            self.viewController = viewController
        }
        
        private var sessionsBySection: [[Session]] {
            
            let currentDay = agenda.days[dayIndex]
            
            var sessionsBySection = [[Session]](repeating: [],
                                                count: currentDay.timeslots.count)
            
            for (index, timeslot) in currentDay.timeslots.enumerated() {
                let sessionsForSection = sessions.filter { timeslot.sessionIds.contains($0.id) && !$0.title.isEmpty }
                sessionsBySection[index] = sessionsForSection
            }
            
            return sessionsBySection
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 130
        }
        func numberOfSections(in tableView: UITableView) -> Int {
            return agenda.days[dayIndex].timeslots.count
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
            return buildCell(for: tableView, at: indexPath, using: session)
            
        }
        
        private func buildCell(for tableView: UITableView, at indexPath: IndexPath, using session: Session) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! RibbonTableViewCell
            
            cell.mainTextLabel.text = session.title
            cell.mainTextLabel.textColor = Color.black.color
            cell.mainTextLabel.font = UIFont.boldSystemFont(ofSize: UIFontMetrics.default.scaledValue(for: 16))

            let timeslot = agenda.days[dayIndex].timeslots[indexPath.section]
            cell.secondaryTextLabel.text = secondaryText(for: indexPath, using: timeslot)
            cell.secondaryTextLabel.textColor = Color.lightOrange.color
            cell.secondaryTextLabel.font = UIFont.systemFont(ofSize: UIFontMetrics.default.scaledValue(for: 14))
            
            cell.tertiaryTextLabel.text = tertiaryText(for: indexPath, using: session)
            cell.tertiaryTextLabel.numberOfLines = 0
            cell.tertiaryTextLabel.lineBreakMode = .byWordWrapping
            cell.tertiaryTextLabel.font = UIFont.systemFont(ofSize: UIFontMetrics.default.scaledValue(for: 12))
            cell.tertiaryTextLabel.textColor = Color.mediumGray.color
            
            if let imageName = speakerThumbnailUrls[session.id] {
                let speakerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
                speakerImageView.image = UIImage(named: imageName)
                speakerImageView.contentMode = .scaleAspectFill
                speakerImageView.clipsToBounds = true
                speakerImageView.layer.cornerRadius = speakerImageView.frame.height / 2
                cell.accessoryView = speakerImageView
            } else {
                cell.accessoryView = nil // nil out the accessory view as cell reuse will cause this to render images where it shouldn't
            }
            
            cell.selectionStyle = .none
            return cell
        }
        
        private func secondaryText(for indexPath: IndexPath, using timeslot: Agenda.Timeslot) -> String {
            
            let startTime = DateFormatter.localizedString(from: timeslot.startTime.date!,
                                                          dateStyle: .none,
                                                          timeStyle: .short)
            
            let endTime = DateFormatter.localizedString(from: timeslot.endTime.date!,
                                                        dateStyle: .none,
                                                        timeStyle: .short)
            let duration = "\(startTime) - \(endTime)"
            return duration
        }
        
        private func tertiaryText(for indexPath: IndexPath, using session: Session) -> String {
            if session.title.lowercased() == "lunch" {
                return ""
            }
            
            let locations = ["Virginia Wimberly Theater",
                             "Nancy and Edward Roberts Studio Theater",
                             "Carol Dean Theatre",]
            
            return locations[indexPath.row]
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let sessionDetails = sessionsBySection[indexPath.section][indexPath.row]
            selectedSession = sessionDetails
            viewController?.performSegue(withIdentifier: "segueToDetailView", sender: self)
        }
    }
}
