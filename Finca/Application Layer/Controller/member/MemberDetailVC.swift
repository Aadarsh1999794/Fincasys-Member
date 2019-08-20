//
//  MemberDetailVC.swift
//  Finca
//
//  Created by anjali on 12/06/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MemberDetailVC: ButtonBarPagerTabStripViewController {
    let bVC = BaseVC()
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var bBack: UIButton!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbAboutUS: UILabel!
    @IBOutlet weak var lblFamilyMemberCount: UILabel!
    @IBOutlet weak var lblTotalParkingCount: UILabel!
    @IBOutlet weak var lblResidentType: UILabel!
    @IBOutlet weak var lbAboutStatus: UILabel!
    @IBOutlet weak var lblFloorDetails: UILabel!
    
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var viewCall: UIView!
    @IBOutlet weak var viewMail: UIView!
    
    var parkingDetails = [MyParkingModal]()
    var emergencyDetails = [MemberEmergencyModal]()
    var familyMemberDetails = [MemberDetailModal]()
    var memMainResponse : MemberDetailResponse!
    
    var alertVC : UIAlertController!
    var selected_residentID : String!
    
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        super.viewDidLoad()
//        doCallApiForMemberDetails()
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            newCell?.label.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        }
       
        viewCall.layer.shadowRadius = 5
        viewCall.layer.shadowOffset = CGSize.zero
        viewCall.layer.shadowOpacity = 0.5
        viewMail.layer.shadowRadius = 5
        viewMail.layer.shadowOffset = CGSize.zero
        viewMail.layer.shadowOpacity = 0.5
        self.emergencyDetails.append(contentsOf: memMainResponse.emergency)
        self.parkingDetails.append(contentsOf: memMainResponse.myParking)
        self.familyMemberDetails.append(contentsOf: memMainResponse.member)
        self.lblFloorDetails.text = memMainResponse.floorName
        self.lbName.text = memMainResponse.userFullName
        self.lblTotalParkingCount.text = "\(memMainResponse.myParking.count)"
        self.lblFamilyMemberCount.text = "\(memMainResponse.member.count)"
        Utils.setImageFromUrl(imageView: self.ivProfile, urlString: memMainResponse.userProfilePic)
        Utils.setRoundImageWithBorder(imageView: self.ivProfile, color: UIColor.white)
        if memMainResponse.userType == "0"{
            self.lblResidentType.text = "Owner"
        }else if memMainResponse.userType == "1"{
            self.lblResidentType.text = "Tenant"
        }
        self.doCreateActionSheetForFamilyMembers()
    }
    
    func doCreateActionSheetForFamilyMembers(){
        alertVC = UIAlertController(title:"", message: "Select Family member", preferredStyle: .actionSheet)
        
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        for items in familyMemberDetails{
            alertVC.addAction(UIAlertAction(title: "\(String(describing: items.userFirstName!)) \(String(describing: items.userLastName!))", style: .default, handler: { action in
                self.actionSheetItemTapped(itemId : items.userId)
            }))
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let storyboard = UIStoryboard(name: "sub", bundle: nil)
        let child1 = storyboard.instantiateViewController(withIdentifier: "idBasicDetailsFragmentVC")as! BasicDetailsFragmentVC
        child1.emergencyDetails = self.emergencyDetails
        child1.familyMemberDetails = self.familyMemberDetails
        child1.parkingDetails = self.parkingDetails
        child1.memberDetailResponse = self.memMainResponse
        let child2 = storyboard.instantiateViewController(withIdentifier: "idProfessionalDetailsVC")as! ProfessionalDetailsVC
        child2.emergencyDetails = self.emergencyDetails
        child2.familyMemberDetails = self.familyMemberDetails
        child2.parkingDetails = self.parkingDetails
        child2.memberDetailResponse = self.memMainResponse
        return [child1,child2]
    }
    
    func doGetMemberDetails()->UnitModelMember{
        var memberData : UnitModelMember? = nil
        if let data = UserDefaults.standard.data(forKey: StringConstants.MEMBER_DETAILS_KEY), let decoded = try? JSONDecoder().decode(UnitModelMember.self, from: data){
            memberData = decoded
        }
        return memberData!
    }
    
    @IBAction func btnFamilMemberTapped(_ sender: UIButton) {
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func actionSheetItemTapped(itemId:String!){
        print(itemId!)
    }
    
    @IBAction func onClickChat(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "idChatVC") as! ChatVC
//        vc.unitModelMember =  unitModelMember
        vc.isGateKeeper = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
//        doPopBAck()
        self.navigationController?.popViewController(animated: true)
    }
}
