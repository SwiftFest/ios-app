//
//  SpeakerDetailView.swift
//  SwiftFest
//
//  Created by Bryan Ryczek on 4/27/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import UIGradient
import UIKit

class SpeakerDetailView: UIView {
    
    var speaker: Speaker?
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerNameLabel: UILabel!
    @IBOutlet weak var speakerTitleLabel: UILabel!
    @IBOutlet weak var speakerBioLabel: UILabel!
    @IBOutlet weak var socialStackView: UIStackView!
    @IBOutlet weak var socialStackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var socialStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var speakerView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var swiftLogoView: UIView!
    
    weak var delegate: DismissModalProtocol!
    
    func uiSetup() {
        speakerImageView.layer.cornerRadius = speakerImageView.frame.height / 2
        self.autoresizesSubviews = false
        self.clipsToBounds = true
        if let speaker = speaker {
            speakerBioLabel.text = speaker.bio
            speakerImageView.image = UIImage(named: speaker.thumbnailUrl!)
            speakerNameLabel.text = speaker.firstName + " " + speaker.lastName
            speakerTitleLabel.text = speaker.title
            generateSocialButtonsForSpeaker(speaker)
        }
        
        gradientView.addGradientWithDirection(.leftToRight, colors: UIUtilities.gradientColors)
        swiftLogoView.isHidden = true
//        let path = UIUtilities.swiftFestLogo()
//        let logoShapeLayer = CAShapeLayer()
//        logoShapeLayer.path = path.cgPath
//        swiftLogoView.layer.addSublayer(logoShapeLayer)
    }
    
    func generateSocialButtonsForSpeaker(_ speaker: Speaker) {
        guard let socialResults = speaker.social else { return }
        let buttonHeight: CGFloat = 50.0
        socialStackViewWidth.constant = CGFloat(socialResults.count) * (buttonHeight) + CGFloat(socialResults.count - 1) * (socialStackView.spacing)
        socialStackViewHeight.constant = buttonHeight
        for social in socialResults {
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
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        delegate.dismiss()
    }
    
}
