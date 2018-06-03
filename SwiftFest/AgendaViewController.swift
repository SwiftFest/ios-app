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

        let baseStyle = StringStyle(
            .font(.boldSystemFont(ofSize: 17))
        )
        let normalAttributes = baseStyle.byAdding(
            .color(Color.white.color.withAlphaComponent(0.6))
            ).attributes
        let selectedAttributes = baseStyle.byAdding(
            .color(Color.white.color)
            ).attributes
        segmentedViewControl.setTitleTextAttributes(normalAttributes, for: .normal)
        segmentedViewControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        segmentedViewControl.setTitleTextAttributes(selectedAttributes, for: .highlighted)
        segmentedViewControl.setTitleTextAttributes(selectedAttributes, for: [.selected, .highlighted])

        segmentedViewControl.setBackgroundImage(Asset.tabUnselected.image, for: .normal, barMetrics: .default)
        segmentedViewControl.setBackgroundImage(Asset.tabSelected.image, for: .selected, barMetrics: .default)
        segmentedViewControl.setBackgroundImage(Asset.tabUnselected.image, for: .highlighted, barMetrics: .default)
        segmentedViewControl.setBackgroundImage(Asset.tabSelected.image, for: [.highlighted, .selected], barMetrics: .default)

        agendaTableView.register(UINib(nibName: "\(RibbonTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "SessionCell")
        agendaTableView.dataSource = agendaTableViewManager
        agendaTableView.delegate = agendaTableViewManager
        agendaTableViewManager.viewController = self
        
    }
    
    @IBAction func changeDay(_ sender: UISegmentedControl) {
        agendaTableViewManager.dayIndex = segmentedViewControl.selectedSegmentIndex
        agendaTableView.reloadData()
        agendaTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
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
                let images = [UIImage(named: imageName)].compactMap { $0 }
                cell.multiImageView.images = images
            } else {
                cell.multiImageView.images = []
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
