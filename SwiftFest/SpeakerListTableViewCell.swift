//
//  SpeakerListTableViewCell.swift
//  SwiftFest
//
//  Created by Bryan Ryczek on 4/25/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import UIKit

class SpeakerListTableViewCell: UITableViewCell {

    var speakerSession: SpeakerSession?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerFirstNameLabel: UILabel!
    @IBOutlet weak var speakerLastNameLabel: UILabel!
    @IBOutlet weak var presentationTitleLabel: UILabel!
    
    func updateUI() {
        guard let speakerSession = speakerSession else { return }
        speakerFirstNameLabel.text = speakerSession.speaker.firstName
        speakerLastNameLabel.text = speakerSession.speaker.lastName
        if let _ = speakerSession.speaker.isEmcee {
            presentationTitleLabel.text = "Emcee"
        } else if let sessions = speakerSession.sessions {
            presentationTitleLabel.text = sessions[0].title
        } else {
            presentationTitleLabel.text = ""
        }
        if let imageName = speakerSession.speaker.thumbnailUrl {
            speakerImageView.image = UIImage(named: imageName)
        }
        let scrollViewFrame = scrollView.frame
        scrollView.maximumZoomScale = 1.5
        scrollView.minimumZoomScale = 1.0
        scrollView.delegate = self
        scrollView.zoom(to: CGRect(x: scrollViewFrame.midX, y: 10, width: scrollViewFrame.width * 0.90, height: scrollViewFrame.height * 0.90), animated: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SpeakerListTableViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return speakerImageView
    }
}
