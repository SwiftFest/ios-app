import UIKit
import BonMot

class SessionDetailView: UIView {
    
    var session: Session?
    
    @IBOutlet weak var sessionTitleLabel: UILabel!
    @IBOutlet weak var sessionDescriptionLabel: UILabel!
    @IBOutlet weak var sessionLanguageLabel: UILabel!
    @IBOutlet weak var complexityTitleLabel: UILabel!
    @IBOutlet weak var sessionComplexityLabel: UILabel!
    @IBOutlet weak var complexityContainerView: UIView!
    @IBOutlet weak var outcomesStackView: UIStackView!
    
    func uiSetup() {
        if let session = session {
            sessionTitleLabel.text = session.title
            sessionDescriptionLabel.text = session.description
            sessionLanguageLabel.text = session.language
            
            if session.complexity != nil {
                sessionComplexityLabel.text = session.complexity
            } else {
                sessionComplexityLabel.isHidden = true
                complexityTitleLabel.isHidden = true
                complexityContainerView.isHidden = true
            }
            
            if let outcomes = session.parsedOutcomes {
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
        }
    }
}
