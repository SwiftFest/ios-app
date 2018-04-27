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
    @IBOutlet weak var speakerDetailContainerView: UIView!
    
    var speakerSession: SpeakerSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let speakerSession = speakerSession, let sessions = speakerSession.sessions {
            guard sessions.count == 1 else { return }
            sessionTitleLabel.text = sessions[0].title
            sessionDescriptionLabel.text = sessions[0].description
            sessionLanguageLabel.text = sessions[0].language
            if sessions[0].complexity != nil {
                sessionComplexityLabel.text = sessions[0].complexity
            } else {
                sessionComplexityLabel.isHidden = true
                complexityTitleLabel.isHidden = true
                complexityContainerView.isHidden = true
            }
            if let outcomes = sessions[0].parsedOutcomes {
                for outcome in outcomes {
                    let outcomeView: OutcomeContainerView = .fromNib()
                    let paragraphStyle = StringStyle(
                        .firstLineHeadIndent(0.0),
                        .headIndent(10.0)
                    )
                    let attributedString = NSAttributedString.composed(of: [
                        outcome
                    ])
                    outcomeView.outcomeLabel.attributedText = attributedString.styled(with: paragraphStyle)
                    outcomesStackView.addArrangedSubview(outcomeView)
                }
            }
            let speakerDetailView: SpeakerDetailView = .fromNib()
            speakerDetailView.speakerBioLabel.text = speakerSession.speaker.bio
            speakerDetailView.speakerImageView.image = UIImage(named: speakerSession.speaker.thumbnailUrl!)
            speakerDetailView.speakerNameLabel.text = speakerSession.speaker.firstName + " " + speakerSession.speaker.lastName
            speakerDetailView.speakerTitleLabel.text = speakerSession.speaker.title
            speakerDetailView.generateSocialButtonsForSpeaker(speakerSession.speaker)
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
