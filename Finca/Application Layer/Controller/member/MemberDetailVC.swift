//
//  MemberDetailVC.swift
//  Finca
//
//  Created by anjali on 12/06/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

class MemberDetailVC: BaseVC {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var ivBuilding: UIImageView!
    
    @IBOutlet weak var bBack: UIButton!
    @IBOutlet weak var lbFamiylCount: UILabel!
     @IBOutlet weak var lbStatus: UILabel!
    
    @IBOutlet weak var lbAboutUS: UILabel!
    @IBOutlet weak var ivProfile: UIImageView!
    
    @IBOutlet weak var lbAboutStatus: UILabel!
    var unitModelMember:UnitModelMember!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        changeButtonImageColor(btn: bBack, image: "back", color: UIColor.white)
        ivBuilding.setImageColor(color: ColorConstant.primaryColor)
       // ivMultiuser.setImageColor(color: ColorConstant.primaryColor)
        
       // lbAboutStatus.isHidden = true
        lbAboutStatus.text = ""
        lbFamiylCount.text = "( " +  unitModelMember.family_count + " Family member)"
       
        
        lbName.text = unitModelMember.user_full_name
        if unitModelMember.unit_status == "3" {
          lbStatus.text = "Re.Type Tenant"
        }else if unitModelMember.unit_status == "1" {
             lbStatus.text = "Re.Type Owner"
        }
        
        Utils.setRoundImageWithBorder(imageView: ivProfile, color: UIColor.white)
        Utils.setImageFromUrl(imageView: ivProfile, urlString: unitModelMember.user_profile_pic)
        //Utils.setU
        
        
      ///  print("sgfdsfd" ,  unitModelMember.about_business)
        if unitModelMember.about_business != "" {
             // lbAboutStatus.isHidden = false
            lbAboutUS.text = unitModelMember.about_business
            lbAboutStatus.text = "About"
        }
        
        //ivProfile
    }
    
    @IBAction func onClickChat(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "idChatVC") as! ChatVC
        vc.unitModelMember =  unitModelMember
         vc.isGateKeeper = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onClickBack(_ sender: Any) {
        doPopBAck()
    }
}
