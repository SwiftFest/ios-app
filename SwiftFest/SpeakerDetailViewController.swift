import BonMot
import SnapKit
import UIKit
import SafariServices

enum DetailType {
    case speakerInfo
    case sessionInfo
}

protocol DismissModalProtocol: class {
    func dismiss()
}

class SpeakerDetailViewController: UIViewController, DismissModalProtocol {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var detailContainerView: UIView!
    @IBOutlet weak var dismissButtonContainerView: UIView!

    var speaker: Speaker?
    var session: Session?
    var detailType: DetailType = .speakerInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.backgroundColor = UIColor(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 0.5).cgColor
        
        switch detailType {
        case .speakerInfo:
            guard let speaker = speaker else { break }
            let speakerDetailView: SpeakerDetailView = .fromNib()
            speakerDetailView.speaker = speaker
            detailContainerView.addSubview(speakerDetailView)
            speakerDetailView.delegate = self
            speakerDetailView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(detailContainerView).offset(8)
                make.left.equalTo(detailContainerView).offset(0)
                make.right.equalTo(detailContainerView).offset(0)
                make.bottom.equalTo(detailContainerView).offset(-12)
            }
            navigationController?.setNavigationBarHidden(true, animated: false)
            speakerDetailView.uiSetup()
            speakerDetailView.socialMediaLinkHandler = { [unowned self] in
                self.present(SFSafariViewController(url: URL(string: $0.link)!), animated: true, completion: nil)
            }
        case .sessionInfo:
            guard let session = session else { break }
            let sessionDetailView = SessionDetailView()
            detailContainerView.addSubview(sessionDetailView)
            sessionDetailView.session = session
            sessionDetailView.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(detailContainerView.safeAreaLayoutGuide)
            }
            
        }
        dismissButtonContainerView.layer.zPosition = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 37 / 255, green: 37 / 255, blue: 37 / 255, alpha: 1.0)
    }
    
    func dismiss() {
        switch detailType {
        case .speakerInfo:
            self.navigationController?.popViewController(animated: true)
            navigationController?.setNavigationBarHidden(false, animated: false)
        case .sessionInfo:
            dismiss(animated: true, completion: nil)
        }
    }
    
}

// to load nib
extension UIView {
    class func fromNib<T: UIView>() -> T {
        // swiftlint:disable:next force_cast
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

// to set background of status bar to black
extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
