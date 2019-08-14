//
//  FloorMemberCell.swift
//  Finca
//
//  Created by anjali on 12/06/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

class FloorMemberCell: UICollectionViewCell {
   
    @IBOutlet weak var lbTitle: UILabel!
     @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet weak var lbCountNoti: UILabel!
    
    @IBOutlet weak var viewMain: RadialGradientSqureView!
  
    @IBOutlet weak var viewAvilabe: RadialGradientSqureView!
    @IBOutlet weak var viewOnwer: UIView!
    @IBOutlet weak var viewDefulter: RadialGradientSqureView!
    @IBOutlet weak var viewRent: RadialGradientSqureView!
    @IBOutlet weak var viewClose: RadialGradientSqureView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewNotification.isHidden = true
     }
    
    
    func setBackUnit(unit_status : String) {
       
        if unit_status == "0" {
            //avilable
            viewOnwer.isHidden = true
            viewAvilabe.isHidden = false
            viewDefulter.isHidden = true
            viewRent.isHidden = true
              viewClose.isHidden  = true
        } else if unit_status == "1" {
            // onwer
            viewOnwer.isHidden = false
            viewAvilabe.isHidden = true
            viewDefulter.isHidden = true
            viewRent.isHidden = true
              viewClose.isHidden  = true
        } else if unit_status == "2" {
            // defuler
            viewOnwer.isHidden = true
            viewAvilabe.isHidden = true
            viewDefulter.isHidden = false
            viewRent.isHidden = true
              viewClose.isHidden  = true
        }else if unit_status == "3" {
            // rent
            viewOnwer.isHidden = true
            viewAvilabe.isHidden = true
            viewDefulter.isHidden = true
            viewRent.isHidden = false
              viewClose.isHidden  = true
        } else if unit_status == "4" {
            // pendeing
            viewOnwer.isHidden = true
            viewAvilabe.isHidden = false
            viewDefulter.isHidden = true
            viewRent.isHidden = true
             viewClose.isHidden  = true
            //cell.viewMain.layer.backgroundColor = ColorConstant.colorEmpty.cgColor
        //    cell.viewMain.InsideColor = ColorConstant.startPending
          //  cell.viewMain.OutsideColor = ColorConstant.endPending
            
        }else if unit_status == "5" {
            // close
            // cell.viewMain.layer.backgroundColor = ColorConstant.colorClose.cgColor
            
          //  cell.viewMain.InsideColor = ColorConstant.startEmptyMember
          //  cell.viewMain.OutsideColor = ColorConstant.endEmptyMember
            viewOnwer.isHidden = true
            viewAvilabe.isHidden = true
            viewDefulter.isHidden = true
            viewRent.isHidden = true
            viewClose.isHidden  = false
        }
        
        
    }
    

}
