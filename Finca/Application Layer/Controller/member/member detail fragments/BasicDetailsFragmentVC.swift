//
//  BasicDetailsFragmentVC.swift
//  Finca
//
//  Created by harsh panchal on 13/08/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class BasicDetailsFragmentVC: BaseVC {
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblMobileNum: UILabel!
    @IBOutlet weak var lblAltMobileNum: UILabel!
    @IBOutlet weak var lblEmailAdder: UILabel!
   
    @IBOutlet weak var lblfacebook: UILabel!
    @IBOutlet weak var lblnstagram: UILabel!
    @IBOutlet weak var lblLinkedIn: UILabel!
    var memberDetailResponse : MemberDetailResponse!
    var parkingDetails = [MyParkingModal]()
    var emergencyDetails = [MemberEmergencyModal]()
    var familyMemberDetails = [MemberDetailModal]()
    let mVC = MemberDetailVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let data =  notification.userInfo?["data"] as? UnitModel
        
        
        lblFirstName.text = memberDetailResponse.userFirstName!
        
        lblLastName.text = memberDetailResponse.userLastName!
        if memberDetailResponse.publicMobile == "1"{
            lblMobileNum.text = memberDetailResponse.userMobile!
        }else if memberDetailResponse.publicMobile == "0"{
            lblMobileNum.text = "**********"
        }
        
        lblEmailAdder.text = memberDetailResponse.userEmail!
    }
}
extension BasicDetailsFragmentVC : IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "BASIC DETAILS"
    }
}
