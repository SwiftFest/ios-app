import BonMot
import SnapKit
import UIKit

class SpeakerDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sessionTitleLabel: UILabel!
    @IBOutlet weak var sessionDescriptionLabel: UILabel!
    @IBOutlet weak var sessionLanguageLabel: UILabel!
    @IBOutlet weak var complexityTitleLabel: UILabel!
    @IBOutlet weak var sessionComplexityLabel: UILabel!
    @IBOutlet weak var complexityContainerView: UIView!
    @IBOutlet weak var outcomesStackView: UIStackView!
    @IBOutlet weak var sessionDetailContainerView: UIView!
    @IBOutlet weak var speakerDetailContainerView: UIView!
    
    var speakerSession: SpeakerSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let speakerSession = speakerSession, let sessions = speakerSession.sessions {
            
            let sessionDetailView: SessionDetailView = .fromNib()
            sessionDetailView.sessions = sessions
            sessionDetailContainerView.addSubview(sessionDetailView)
            sessionDetailView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(sessionDetailContainerView).offset(8)
                make.left.equalTo(sessionDetailContainerView).offset(0)
                make.right.equalTo(sessionDetailContainerView).offset(0)
                make.bottom.equalTo(sessionDetailContainerView).offset(-12)
            }
            sessionDetailView.uiSetup()
            

            let speakerDetailView: SpeakerDetailView = .fromNib()
            speakerDetailView.speaker = speakerSession.speaker
            speakerDetailContainerView.addSubview(speakerDetailView)
            speakerDetailView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(speakerDetailContainerView).offset(8)
                make.left.equalTo(speakerDetailContainerView).offset(0)
                make.right.equalTo(speakerDetailContainerView).offset(0)
                make.bottom.equalTo(speakerDetailContainerView).offset(-12)
            }
            speakerDetailView.uiSetup()
        }
    }

    @IBAction func dismissButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// to load nib
extension UIView {
    class func fromNib<T: UIView>() -> T {
        // swiftlint:disable:next force_cast
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
