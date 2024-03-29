import UIKit

class TeamViewController: BaseViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var selectedTeamMember: TeamMember?

    var teamMembers: [TeamMember] = [] {
        didSet {
            let organizers = Section(title: TeamMember.Kind.organizer.displaySectionString, items: teamMembers.filter { $0.kind == .organizer })
            let mcs = Section(title: TeamMember.Kind.mc.displaySectionString, items: teamMembers.filter { $0.kind == .mc })
            let volunteers = Section(title: TeamMember.Kind.volunteer.displaySectionString, items: teamMembers.filter { $0.kind == .volunteer })
            sections = [organizers, mcs, volunteers]
        }
    }

    private var sections: [Section<TeamMember>] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib(nibName: "RibbonTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamMemberListTableViewCell")

        NotificationCenter.default.addObserver(self, selector: #selector(newDataAvailable), name: AppDataController.Notifications.dataDidUpdate, object: nil)

        updateData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let teamMemberViewController = segue.destination as? SpeakerDetailViewController {
            teamMemberViewController.detailType = SpeakerDetailViewController.DetailType(selectedTeamMember!)
            teamMemberViewController.transitioningDelegate = self
        }
    }

}

// MARK: - Notifications

private extension TeamViewController {

    @objc func newDataAvailable(_ notification: Notification) {
        updateData()
    }

}

// MARK: - Private

private extension TeamViewController {

    func updateData() {
        teamMembers = AppDataController.shared.teamMembers
    }

}

// MARK: - Table View Stuff

extension TeamViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamMemberListTableViewCell", for: indexPath) as! RibbonTableViewCell

        let teamMember = sections[indexPath.section].items[indexPath.row]

        cell.mainTextLabel.text = teamMember.name
        cell.mainTextLabel.textColor = Color.black.color
        cell.mainTextLabel.font = UIFont.boldSystemFont(ofSize: UIFontMetrics.default.scaledValue(for: 18))
        
        cell.secondaryTextLabel.text = teamMember.role
        
        cell.secondaryTextLabel.font = UIFont.systemFont(ofSize: UIFontMetrics.default.scaledValue(for: 12))
        cell.secondaryTextLabel.textColor = Color.black.color
        cell.secondaryTextLabel.numberOfLines = 0
        cell.secondaryTextLabel.lineBreakMode = .byWordWrapping

        cell.tertiaryTextLabel.text = ""
        
        let imageName = teamMember.thumbnailUrl
        cell.multiImageView.setImageNames([imageName], completionHandler: nil)

        cell.selectionStyle = .none

        cell.ribbon.backgroundColor = Color.lightOrange.color
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTeamMember = sections[indexPath.section].items[indexPath.row]
        self.performSegue(withIdentifier: "TeamMemberDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return 16 }
}

private extension TeamViewController {

    struct Section<T> {
        let title: String
        let items: [T]
        var count: Int {
            return items.count
        }
    }

}
