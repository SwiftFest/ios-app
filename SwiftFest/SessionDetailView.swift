//
//  SessionDetailView.swift
//  SwiftFest
//
//  Created by Bryan Ryczek on 5/3/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import UIKit
import BonMot

class SessionDetailView: UIView {
    
    var sessions : [Session]?
    
    @IBOutlet weak var sessionTitleLabel: UILabel!
    @IBOutlet weak var sessionDescriptionLabel: UILabel!
    @IBOutlet weak var sessionLanguageLabel: UILabel!
    @IBOutlet weak var complexityTitleLabel: UILabel!
    @IBOutlet weak var sessionComplexityLabel: UILabel!
    @IBOutlet weak var complexityContainerView: UIView!
    @IBOutlet weak var outcomesStackView: UIStackView!
    
    func uiSetup() {
        if let sessions = sessions {
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
        }
        
    }
}
