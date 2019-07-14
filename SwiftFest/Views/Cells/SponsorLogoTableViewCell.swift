//
//  SponsorLogoTableViewCell.swift
//  SwiftFest
//
//  Created by Matthew Dias on 7/14/19.
//  Copyright © 2019 Sean Olszewski. All rights reserved.
//

import UIKit

class SponsorLogoTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        logoImageView.image = nil
    }
}
