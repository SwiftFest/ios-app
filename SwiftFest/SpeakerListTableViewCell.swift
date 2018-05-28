import UIKit

class SpeakerListTableViewCell: UITableViewCell {

    var speakerSession: SpeakerSession?
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerFirstNameLabel: UILabel!
    @IBOutlet weak var speakerLastNameLabel: UILabel!
    
    func updateUI() {
        guard let speakerSession = speakerSession else { return }
        speakerFirstNameLabel.text = speakerSession.speaker.firstName
        speakerLastNameLabel.text = speakerSession.speaker.lastName

        if let imageName = speakerSession.speaker.thumbnailUrl {
            speakerImageView.image = UIImage(named: imageName)
            speakerImageView.layer.cornerRadius = 8.0
        }
    }
}

extension SpeakerListTableViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return speakerImageView
    }
}
