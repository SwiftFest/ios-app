//
//  SpeakerDetailView.swift
//  SwiftFest
//
//  Created by Bryan Ryczek on 4/27/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import UIKit

class SpeakerDetailView: UIView {

    var speaker: Speaker?
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerNameLabel: UILabel!
    @IBOutlet weak var speakerTitleLabel: UILabel!
    @IBOutlet weak var speakerBioLabel: UILabel!
    @IBOutlet weak var socialStackView: UIStackView!
    
    var socialUrls: [URL] = []
    
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
        
    }
    
    func generateSocialButtonsForSpeaker(_ speaker: Speaker) {
        guard let socialResults = speaker.social else { return }
        for (index, social) in socialResults.enumerated() {
            let socialButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0))
            socialButton.tag = index
            if let url = URL(string: social.link) {
                socialUrls.append(url)
            }
            let socialImage = UIImage(named: (social.socialType?.rawValue)!)
            socialButton.setImage(socialImage, for: .normal)
            socialButton.addTarget(self, action: #selector(openSocialUrl), for: .touchUpInside)
            socialStackView.addArrangedSubview(socialButton)
        }
    }
    
    @objc func openSocialUrl(sender: UIButton) {
        guard socialUrls.count >= sender.tag else { return }
        let url = socialUrls[sender.tag]
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
