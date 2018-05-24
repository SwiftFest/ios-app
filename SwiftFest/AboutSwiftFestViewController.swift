//
//  AboutSwiftFestViewController.swift
//  SwiftFest
//
//  Created by Bryan Ryczek on 5/21/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//


import SnapKit
import UIKit

class AboutSwiftFestViewController: UIViewController {

    @IBOutlet weak var logoContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogoView()
    }

    func setupLogoView() {
        //load logoview
        let logoView: SwiftLogoView = .fromNib()
        logoContainerView.addSubview(logoView)
        logoView.snp.makeConstraints { (make) -> Void in
        make.top.equalTo(logoContainerView)
        make.left.equalTo(logoContainerView)
        make.right.equalTo(logoContainerView)
        make.bottom.equalTo(logoContainerView)
        }
        logoView.setup(containerViewFrame: logoContainerView.frame)
    }
}
