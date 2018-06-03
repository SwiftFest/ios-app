import BonMot
import Down
import UIKit

protocol SpeakerDetailViewModel {
    var bio: String? { get }
    var firstName: String { get }
    var lastName: String { get }
    var name: String { get }
    var role: String? { get }
    var thumbnailUrl: String { get }
    var social: [Social] { get }
}

extension SpeakerDetailViewModel {
    var name: String {
        return firstName + " " + lastName
    }
}

class SpeakerDetailView: UIView {
    
    var viewModel: SpeakerDetailViewModel?
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerNameLabel: UILabel!
    @IBOutlet weak var speakerTitleLabel: UILabel!
    @IBOutlet weak var speakerBioLabel: UILabel!
    @IBOutlet weak var socialStackView: UIStackView!
    @IBOutlet weak var socialStackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var socialStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var speakerView: UIView!
    @IBOutlet weak var gradientView: GradientView!
    
    weak var delegate: DismissModalProtocol!
    
    var socialMediaLinkHandler: ((Social) -> Void)?
    
    func uiSetup() {
        speakerImageView.layer.cornerRadius = speakerImageView.frame.height / 2
        self.autoresizesSubviews = false
        self.clipsToBounds = true
        if let speaker = viewModel {
            speakerImageView.image = UIImage(named: speaker.thumbnailUrl)
            speakerNameLabel.text = speaker.name
            
            let textStyle = StringStyle(
                .font(.preferredFont(forTextStyle: .body)),
                .color(Asset.Colors.black.color)
            )
            
            let style = StringStyle(
                .xmlRules([
                    .style("a", textStyle),
                    .style("body", textStyle),
                ])
            )
            let down = Down(markdownString: speaker.bio ?? "No information provided.")
            let parsedMarkdown = try? down.toHTML(.smart)
            let bio = parsedMarkdown?.styled(with: style)
            
            speakerBioLabel.attributedText = bio

            speakerTitleLabel.text = speaker.role
            speakerTitleLabel.numberOfLines = 0
            speakerTitleLabel.sizeToFit()
            generateSocialButtons(for: speaker)
        }

        gradientView.colors = UIUtilities.gradientColors
    }
    
    func generateSocialButtons(for viewModel: SpeakerDetailViewModel) {
        let buttonHeight: CGFloat = 50.0
        socialStackViewWidth.constant = CGFloat(viewModel.social.count) * (buttonHeight) + CGFloat(viewModel.social.count - 1) * (socialStackView.spacing)
        socialStackViewHeight.constant = buttonHeight
        for (index, social) in viewModel.social.enumerated() {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: buttonHeight, height: buttonHeight))
            view.backgroundColor = Color.white.color
            view.layer.cornerRadius = view.frame.height / 2
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = CGSize(width: 0, height: 1)
            let socialButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonHeight, height: buttonHeight))
            view.addSubview(socialButton)
            let socialImage = UIImage(named: (social.socialType?.rawValue)!)
            socialButton.setImage(socialImage, for: .normal)
            socialStackView.addArrangedSubview(view)
            
            socialButton.addTarget(self, action: #selector(socialMediaButtonPressed), for: .touchUpInside)
            socialButton.tag = index
        }
    }
    
    @objc
    func socialMediaButtonPressed(sender: UIButton) {
        guard let social = viewModel?.social[sender.tag] else { return }
        socialMediaLinkHandler?(social)
    }
}
