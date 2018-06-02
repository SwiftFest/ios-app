import UIKit

class TeamViewController: BaseViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var selectedTeamMember: TeamMember?

    var teamMembers: [TeamMember] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        teamMembers = AppDataController().fetchTeamMembers()

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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamMemberListTableViewCell", for: indexPath) as! RibbonTableViewCell
        
        cell.mainTextLabel.text = teamMembers[indexPath.row].name
        cell.mainTextLabel.textColor = Color.black.color
        cell.mainTextLabel.font = UIFont.boldSystemFont(ofSize: UIFontMetrics.default.scaledValue(for: 18))
        
        cell.secondaryTextLabel.text = teamMembers[indexPath.row].role
        
        cell.secondaryTextLabel.font = UIFont.systemFont(ofSize: UIFontMetrics.default.scaledValue(for: 12))
        cell.secondaryTextLabel.textColor = Color.mediumGray.color
        cell.secondaryTextLabel.numberOfLines = 0
        cell.secondaryTextLabel.lineBreakMode = .byWordWrapping

        cell.tertiaryTextLabel.text = ""
        
        let imageName = teamMembers[indexPath.row].thumbnailUrl
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        cell.accessoryView = imageView

        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTeamMember = teamMembers[indexPath.row]
        self.performSegue(withIdentifier: "TeamMemberDetailSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
