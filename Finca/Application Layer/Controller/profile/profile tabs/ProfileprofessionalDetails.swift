//
//  ProfileprofessionalDetails.swift
//  Finca
//
//  Created by harsh panchal on 09/08/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class ProfileprofessionalDetails: BaseVC {
    @IBOutlet weak var lblAboutUS: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if doGetLocalDataUser().about_business != nil {
            lblAboutUS.text = doGetLocalDataUser().about_business
        }
        
    }
    
    @IBAction func btnAboutMySelf(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier:
            "idAboutSelfVC")as! AboutSelfVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension ProfileprofessionalDetails : IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "Professional Details"
    }
}
