//
//  SpeakerDetailViewController.swift
//  SwiftFest
//
//  Created by Bryan Ryczek on 4/23/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import UIKit

class SpeakerDetailViewController: UIViewController {

    @IBOutlet weak var presentationTitleLabel: UILabel!
    
    var speaker : Speaker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let speaker = speaker {
            presentationTitleLabel.text = speaker.presentationsForSpeakerId(speaker.id)[0].title
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
