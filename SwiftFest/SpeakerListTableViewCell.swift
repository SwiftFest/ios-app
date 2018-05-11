//
//  SpeakerListTableViewCell.swift
//  SwiftFest
//
//  Created by Bryan Ryczek on 4/25/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import UIKit


//hack so I can pass multiple items through sender
struct SpeakerSessionDetailType {
    let detailType : DetailType
    let speakerSession : SpeakerSession
}

class SpeakerListTableViewCell: UITableViewCell {

    var speakerSession: SpeakerSession?
    var delegate: SpeakerListTableViewCellDelegate!
    
    //@IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var speakerFirstNameLabel: UILabel!
    @IBOutlet weak var speakerLastNameLabel: UILabel!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var sessionInfoButton: UIButton!
    @IBOutlet weak var sessionInfoButtonContainerView: UIView!
    
    func updateUI() {
        guard let speakerSession = speakerSession else { return }
        let aboutButtonTitle = "About \(speakerSession.speaker.firstName)"
        aboutButton.setTitle(aboutButtonTitle, for: .normal)
        sessionInfoButton.setTitle("Session Info", for: .normal)
        speakerFirstNameLabel.text = speakerSession.speaker.firstName
        speakerLastNameLabel.text = speakerSession.speaker.lastName

        if speakerSession.speaker.isEmcee == true {
            //sessionInfoButton.isHidden = true
            //sessionInfoButtonContainerView.frame = CGRect(x: 0, y: 0, width: 0, height: sessionInfoButtonContainerView.frame.height)
            //presentationTitleLabel.text = "Emcee"
        }
        if let imageName = speakerSession.speaker.thumbnailUrl {
            speakerImageView.image = UIImage(named: imageName)
            speakerImageView.layer.cornerRadius = 8.0
        }
//        let scrollViewFrame = scrollView.frame
//        scrollView.maximumZoomScale = 1.5
//        scrollView.minimumZoomScale = 1.0
//        scrollView.delegate = self
//        scrollView.zoom(to: CGRect(x: scrollViewFrame.midX, y: 10, width: scrollViewFrame.width * 0.90, height: scrollViewFrame.height * 0.90), animated: true)
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
        delegate.buttonTapped(speakerSessionDetailType: SpeakerSessionDetailType(detailType: .sessionInfo, speakerSession: speakerSession))
    }
}

extension SpeakerListTableViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return speakerImageView
    }
}
