import BonMot
import SnapKit
import UIKit

class AgendaViewController: BaseViewController {

    @IBOutlet weak var agendaTableView: UITableView!
    @IBOutlet weak var segmentedViewControl: UISegmentedControl!
    
    let agendaTableViewManager = TableViewManager(agenda: AppDataController().fetchAgenda(),
                                                  sessions: AppDataController().fetchSessions(),
                                                  speakerThumbnailUrls: AppDataController().fetchSpeakerThumbnailUrls(),
                                                  viewController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        let logoView = UIImageView(image: UIImage(asset: Asset.logo))
        logoView.accessibilityLabel = L10n.Screen.Agenda.title
        logoView.contentMode = .scaleAspectFit
        logoView.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
        logoView.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.titleView = logoView

        segmentedViewControl.backgroundColor = Color.black.color
        segmentedViewControl.tintColor = UIColor.clear
        segmentedViewControl.contentMode = .scaleAspectFill
        

        agendaTableView.register(UINib(nibName: "\(RibbonTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "SessionCell")
        agendaTableView.dataSource = agendaTableViewManager
        agendaTableView.delegate = agendaTableViewManager
        agendaTableViewManager.viewController = self
        
    }
    
    @IBAction func changeDay(_ sender: UISegmentedControl) {
        agendaTableViewManager.dayIndex = segmentedViewControl.selectedSegmentIndex
        agendaTableView.reloadData()
        agendaTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        
        let day1Selected = UIImage(named: Asset.day1Selected.name)
        let day2Selected = UIImage(named: Asset.day2Selected.name)
        let day1Unselected = UIImage(named: Asset.day1Unselected.name)
        let day2Unselected = UIImage(named: Asset.day2Unselected.name)

        if sender.selectedSegmentIndex == 0 {
            sender.setImage(day1Selected, forSegmentAt: 0)
            sender.setImage(day2Unselected, forSegmentAt: 1)
        } else {
            sender.setImage(day1Unselected, forSegmentAt: 0)
            sender.setImage(day2Selected, forSegmentAt: 1)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToDetailView",
            let destinationController = segue.destination as? SpeakerDetailViewController,
            let session = agendaTableViewManager.selectedSession {
            destinationController.detailType = SpeakerDetailViewController.DetailType(session)
        }
        
    }
    
}

extension AgendaViewController {
    
    class TableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {

        var dayIndex: Int = 0

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

            let titleStyle = StringStyle(
                .font(UIFont.boldSystemFont(ofSize: UIFontMetrics.default.scaledValue(for: 16))),
                .color(Color.black.color),
                .xmlRules([]) //Will force xml parsing and escaping
            )
            
            cell.mainTextLabel.attributedText = session.title.styled(with: titleStyle)
            
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
                             "Carol Dean Theatre",
                             ]
            
            return locations[indexPath.row]
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let sessionDetails = sessionsBySection[indexPath.section][indexPath.row]
            selectedSession = sessionDetails
            viewController?.performSegue(withIdentifier: "segueToDetailView", sender: self)
        }
    }
}
