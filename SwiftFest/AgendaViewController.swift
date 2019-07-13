import BonMot
import SnapKit
import UIKit

class AgendaViewController: BaseViewController {

    @IBOutlet weak var agendaTableView: UITableView!
    @IBOutlet weak var segmentedViewControl: UISegmentedControl!
    
    let agendaTableViewManager = TableViewManager(agenda: AppDataController.shared.agenda,
                                                  sessions: AppDataController.shared.sessions,
                                                  speakersById: AppDataController.shared.speakersById,
                                                  viewController: nil)

    private var hasDoneInitialRefresh = false

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
            .font(.preferredFont(forTextStyle: .headline))
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
        agendaTableView.sectionHeaderHeight = UITableViewAutomaticDimension
        agendaTableViewManager.viewController = self

        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterForeground(_:)), name: .UIApplicationDidBecomeActive, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !hasDoneInitialRefresh {
            hasDoneInitialRefresh = true
            refreshData()
        }
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

private extension AgendaViewController {

    @objc func appDidEnterForeground(_ notification: Notification) {
        refreshData()
    }

    func refreshData() {
        AppDataController.shared.refreshFromNetwork { success in
            guard success else { return }
            self.agendaTableViewManager.update(
                agenda: AppDataController.shared.agenda,
                sessions: AppDataController.shared.sessions,
                speakersById: AppDataController.shared.speakersById
            )
        }
    }

}

extension AgendaViewController {
    
    class TableViewManager: NSObject {

        var dayIndex: Int = 0

        var selectedSession: Session?
        
        private var agenda: Agenda
        private var sessions: [Session]
        private var speakersById: [Identifier<Speaker>: Speaker]

        weak var viewController: AgendaViewController?

        init(agenda: Agenda,
             sessions: [Session],
             speakersById: [Identifier<Speaker>: Speaker],
             viewController: AgendaViewController?) {
            self.agenda = agenda
            self.sessions = sessions
            self.speakersById = speakersById
            self.viewController = viewController
        }

        func update(agenda: Agenda, sessions: [Session], speakersById: [Identifier<Speaker>: Speaker]) {
            self.agenda = agenda
            self.sessions = sessions
            self.speakersById = speakersById
            viewController?.agendaTableView.reloadData()
        }

    }
}

private extension AgendaViewController.TableViewManager {

    var sessionsBySection: [[Session]] {

        let currentDay = agenda.days[dayIndex]

        var sessionsBySection = [[Session]](repeating: [],
                                            count: currentDay.timeslots.count)

        for (index, timeslot) in currentDay.timeslots.enumerated() {
            sessionsBySection[index] = timeslot.sessionIds.compactMap { sessionID in
                sessions.first { $0.id == sessionID && !$0.title.isEmpty }
            }
        }

        return sessionsBySection
    }

    func tertiaryText(for indexPath: IndexPath, using session: Session) -> String {
        if session.title.lowercased() == "lunch" {
            return ""
        }

        let locations = [
            "Virginia Wimberly Theater",
            "Nancy and Edward Roberts Studio Theater",
            "Carol Dean Theatre",
        ]

        return locations[indexPath.row]
    }

    func secondaryText(for indexPath: IndexPath, using speakerIds: [Identifier<Speaker>]) -> String {
        return speakerIds.compactMap { speakersById[$0]?.name }.joined(separator: ", ")
    }

    func buildCell(for tableView: UITableView, at indexPath: IndexPath, using session: Session) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! RibbonTableViewCell

        let titleStyle = StringStyle(
            .font(UIFont.boldSystemFont(ofSize: UIFontMetrics.default.scaledValue(for: 16))),
            .color(Color.black.color),
            .xmlRules([]) //Will force xml parsing and escaping
        )

        cell.mainTextLabel.attributedText = session.title.styled(with: titleStyle)

        let speakerIds = session.speakers
        cell.secondaryTextLabel.text = secondaryText(for: indexPath, using: speakerIds)
        cell.secondaryTextLabel.textColor = Color.black.color
        cell.secondaryTextLabel.font = UIFont.systemFont(ofSize: UIFontMetrics.default.scaledValue(for: 14))

        cell.tertiaryTextLabel.text = tertiaryText(for: indexPath, using: session)
        cell.tertiaryTextLabel.numberOfLines = 0
        cell.tertiaryTextLabel.lineBreakMode = .byWordWrapping
        cell.tertiaryTextLabel.font = UIFont.systemFont(ofSize: UIFontMetrics.default.scaledValue(for: 12))
        cell.tertiaryTextLabel.textColor = Color.mediumGray.color

        let imagesNames = speakerIds.compactMap { speakersById[$0]?.thumbnailUrl }
        cell.multiImageView.setImageNames(imagesNames, completionHandler: nil)

        cell.selectionStyle = .none

        cell.ribbon.backgroundColor = agenda.days[dayIndex].tracks[indexPath.row].uiColor
        return cell
    }

}

extension AgendaViewController.TableViewManager: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return agenda.days[dayIndex].timeslots.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionsBySection[section].count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let startTime = agenda.days[dayIndex].timeslots[section].startTime
        return DateFormatter.localizedString(from: startTime.date!,
                                             dateStyle: .none,
                                             timeStyle: .short)
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

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return 16 }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(named: "TableViewBackground")!
        
        return view
    }
}

extension AgendaViewController.TableViewManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sessionDetails = sessionsBySection[indexPath.section][indexPath.row]
        selectedSession = sessionDetails
        viewController?.performSegue(withIdentifier: "segueToDetailView", sender: self)
    }

}
