import BonMot
import SafariServices
import SnapKit
import UIKit

protocol DismissModalProtocol: class {
    func dismiss()
}

class SpeakerDetailViewController: UIViewController, DismissModalProtocol {

    enum DetailType {
        case speaker(Speaker)
        case teamMember(TeamMember)
        case session(Session)

        init(_ speaker: Speaker) {
            self = .speaker(speaker)
        }

        init(_ teamMember: TeamMember) {
            self = .teamMember(teamMember)
        }

        init(_ session: Session) {
            self = .session(session)
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var detailContainerView: UIView!

    var detailType: DetailType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.backgroundColor = UIColor(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 0.5).cgColor
        
        switch detailType {
        case .speaker(let speaker)?:
            let speakerDetailView: SpeakerDetailView = .fromNib()
            speakerDetailView.viewModel = speaker
            detailContainerView.addSubview(speakerDetailView)
            speakerDetailView.delegate = self
            speakerDetailView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(detailContainerView).offset(0)
                make.left.equalTo(detailContainerView).offset(0)
                make.right.equalTo(detailContainerView).offset(0)
                make.bottom.equalTo(detailContainerView).offset(0)
            }
            speakerDetailView.uiSetup()
            speakerDetailView.socialMediaLinkHandler = { [unowned self] in
                self.present(SFSafariViewController(url: URL(string: $0.link)!), animated: true, completion: nil)
            }
        case .teamMember(let teamMember)?:
            let speakerDetailView: SpeakerDetailView = .fromNib()
            speakerDetailView.viewModel = teamMember
            detailContainerView.addSubview(speakerDetailView)
            speakerDetailView.delegate = self
            speakerDetailView.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(detailContainerView)
            }
            speakerDetailView.uiSetup()
            speakerDetailView.socialMediaLinkHandler = { [unowned self] in
                self.present(SFSafariViewController(url: URL(string: $0.link)!), animated: true, completion: nil)
            }
        case .session(let session)?:
            let sessionDetailView = SessionDetailView()
            detailContainerView.addSubview(sessionDetailView)
            sessionDetailView.session = session
            sessionDetailView.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(detailContainerView.safeAreaLayoutGuide)
            }
        default:
            fatalError("we should never try to view a nil detail type")
        }
    }

    func dismiss() {
        switch detailType {
        case .speaker?, .teamMember?:
            self.navigationController?.popViewController(animated: true)
        case .session?:
            dismiss(animated: true, completion: nil)
        case .none:
            fatalError("What were you expecting?")
        }
    }
    
}

// to load nib
extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

// to set background of status bar to black
extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
