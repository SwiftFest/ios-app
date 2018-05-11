import BonMot
import SnapKit
import UIKit

enum DetailType {
    case speakerInfo
    case sessionInfo
}

class SpeakerDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var detailContainerView: UIView!
    @IBOutlet weak var dismissButtonContainerView: UIView!
    
    var speakerSession: SpeakerSession?
    var detailType: DetailType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let speakerSession = speakerSession else { return }
        
        self.view.layer.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.5).cgColor
        scrollView.layer.cornerRadius = 8.0
        scrollView.layer.borderWidth = 1.0
        scrollView.layer.borderColor = UIColor.darkGray.cgColor
        
        if let detailType = detailType {
            switch detailType {
                case .speakerInfo:
                    let speakerDetailView: SpeakerDetailView = .fromNib()
                    speakerDetailView.speaker = speakerSession.speaker
                    detailContainerView.addSubview(speakerDetailView)
                    speakerDetailView.snp.makeConstraints { (make) -> Void in
                        make.top.equalTo(detailContainerView).offset(8)
                        make.left.equalTo(detailContainerView).offset(0)
                        make.right.equalTo(detailContainerView).offset(0)
                        make.bottom.equalTo(detailContainerView).offset(-12)
                    }
                    speakerDetailView.uiSetup()
                case .sessionInfo:
                    guard let session = speakerSession.session else { break }
                    let sessionDetailView: SessionDetailView = .fromNib()
                    sessionDetailView.session = session
                    detailContainerView.addSubview(sessionDetailView)
                    sessionDetailView.snp.makeConstraints { (make) -> Void in
                        make.top.equalTo(detailContainerView).offset(8)
                        make.left.equalTo(detailContainerView).offset(0)
                        make.right.equalTo(detailContainerView).offset(0)
                        make.bottom.equalTo(detailContainerView).offset(-12)
                    }
                    sessionDetailView.uiSetup()
            }
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
