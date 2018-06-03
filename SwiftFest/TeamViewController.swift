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
        teamMembers = AppDataController.shared.teamMembers

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "RibbonTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamMemberListTableViewCell")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let teamMemberViewController = segue.destination as? SpeakerDetailViewController {
            teamMemberViewController.detailType = SpeakerDetailViewController.DetailType(selectedTeamMember!)
            teamMemberViewController.transitioningDelegate = self
        }
    }

}

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
        cell.secondaryTextLabel.textColor = Color.mediumGray.color
        cell.secondaryTextLabel.numberOfLines = 0
        cell.secondaryTextLabel.lineBreakMode = .byWordWrapping

        cell.tertiaryTextLabel.text = ""
        
        let imageName = teamMember.thumbnailUrl
        cell.multiImageView.images = [UIImage(named: imageName)].compactMap { $0 }

        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTeamMember = sections[indexPath.section].items[indexPath.row]
        self.performSegue(withIdentifier: "TeamMemberDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
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
