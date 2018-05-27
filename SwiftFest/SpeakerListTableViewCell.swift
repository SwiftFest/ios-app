import UIKit

//hack so I can pass multiple items through sender
struct SpeakerSessionDetailType {
    let detailType: DetailType
    let speakerSession: SpeakerSession
}

class SpeakerListTableViewCell: UITableViewCell {

    var speakerSession: SpeakerSession?
    weak var delegate: SpeakerListTableViewCellDelegate!
    
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerFirstNameLabel: UILabel!
    @IBOutlet weak var speakerLastNameLabel: UILabel!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var sessionInfoButtonContainerView: UIView!
    
    func updateUI() {
        guard let speakerSession = speakerSession else { return }
        let aboutButtonTitle = "About \(speakerSession.speaker.firstName)"
        aboutButton.setTitle(aboutButtonTitle, for: .normal)
        speakerFirstNameLabel.text = speakerSession.speaker.firstName
        speakerLastNameLabel.text = speakerSession.speaker.lastName


        if let imageName = speakerSession.speaker.thumbnailUrl {
            speakerImageView.image = UIImage(named: imageName)
            speakerImageView.layer.cornerRadius = 8.0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func aboutButtonTapped(_ sender: Any) {
        guard let speakerSession = speakerSession else { return }
        delegate.buttonTapped(speakerSessionDetailType: SpeakerSessionDetailType(detailType: .speakerInfo, speakerSession: speakerSession))
    }
    

    @IBAction func sessionInfoButtonTapped(_ sender: Any) { 
        guard let speakerSession = speakerSession else { return }
        delegate.buttonTapped(speakerSessionDetailType:  SpeakerSessionDetailType(detailType: .sessionInfo, speakerSession: speakerSession))//

    }
}

extension SpeakerListTableViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return speakerImageView
    }
}
