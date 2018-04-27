//
//  SpeakerDetailView.swift
//  SwiftFest
//
//  Created by Bryan Ryczek on 4/27/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import UIKit

class SpeakerDetailView: UIView {

    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerNameLabel: UILabel!
    @IBOutlet weak var speakerTitleLabel: UILabel!
    @IBOutlet weak var speakerBioLabel: UILabel!
    @IBOutlet weak var socialStackVIew: UIStackView!
    
    func generateSocialButtonsForSpeaker(_ speaker: Speaker) {
        guard let socialResults = speaker.social else { return }
        for social in socialResults {
            let socialButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0))
            socialButton.addTarget(self, action: <#T##Selector#>, for: <#T##UIControlEvents#>)
        }
    }
    
}
