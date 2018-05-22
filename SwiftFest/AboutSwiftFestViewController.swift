//
//  AboutSwiftFestViewController.swift
//  SwiftFest
//
//  Created by Bryan Ryczek on 5/21/18.
//  Copyright © 2018 Sean Olszewski. All rights reserved.
//

import UIKit
import SnapKit

class AboutSwiftFestViewController: UIViewController {

    @IBOutlet weak var logoContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load logoview
        let logoView: SwiftLogoView = .fromNib()
        logoContainerView.addSubview(logoView)
        logoView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(logoContainerView)
            make.left.equalTo(logoContainerView)
            make.right.equalTo(logoContainerView)
            make.bottom.equalTo(logoContainerView)
        }
        logoView.setup()
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
