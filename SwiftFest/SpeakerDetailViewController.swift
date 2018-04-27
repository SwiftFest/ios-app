//
//  SpeakerDetailViewController.swift
//  SwiftFest
//
//  Created by Bryan Ryczek on 4/23/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

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
                    //let stringParagraphStyle = NSMutableParagraphStyle()
                    //let attributedString = NSMutableAttributedString(string: outcome, attributes: nil)
                    //attributedString.addAttributes(<#T##attrs: [NSAttributedStringKey : Any]##[NSAttributedStringKey : Any]#>, range: <#T##NSRange#>)
                    outcomeView.outcomeLabel.text = outcome
                    outcomesStackView.addArrangedSubview(outcomeView)
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// to load nib
extension UIView {
    class func fromNib<T: UIView>() -> T {
        // swiftlint:disable:next force_cast
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
