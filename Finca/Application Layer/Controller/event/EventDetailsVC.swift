//
//  EventDetailsVC.swift
//  Finca
//
//  Created by anjali on 03/07/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

class EventDetailsVC: BaseVC {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var bEdit: UIButton!
    @IBOutlet weak var bYes: UIButton!
     @IBOutlet weak var lbExtraNote: UILabel!
    
    @IBOutlet weak var stackAttaent: UIStackView!
    @IBOutlet weak var lbNote: UILabel!
    @IBOutlet weak var lbAttendPerson: UILabel!
    @IBOutlet weak var lbAttentStatus: UILabel!
    var eventModeL:ModelEvent!
    
    @IBOutlet weak var heightConExtraNote: NSLayoutConstraint!
    @IBOutlet weak var lbGoing: UILabel!
    var attendPerson = ""
    var notes_person   = ""
    @IBOutlet weak var ivImage: UIImageView!
    
    @IBOutlet weak var viewExtraNote: DashedBorderView!
    @IBOutlet weak var lbFamilyCount: UILabel!
    
    @IBOutlet weak var heightButton: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lbTitle.text = eventModeL.event_title
         lbDesc.text = eventModeL.event_description
        lbDate.text = eventModeL.event_start_date
        
        if eventModeL.going_person == "0" {
            lbFamilyCount.text = eventModeL.numberof_person
            lbExtraNote.text = eventModeL.booked_by
            heightConExtraNote.constant = 40
             viewExtraNote.isHidden = false
        } else {
             lbFamilyCount.text = "0"
             heightConExtraNote.constant = 0
            lbExtraNote.text  = ""
            viewExtraNote.isHidden = true
        }
     
        
         lbTitle.layer.cornerRadius = 3
        bEdit.layer.cornerRadius = 3
        bYes.layer.cornerRadius = 3
        Utils.setImageFromUrl(imageView: ivImage, urlString: eventModeL.event_image)
        
        if eventModeL.going_person == "0" {
            bYes.setTitle("EDIT", for: .normal)
        }
     
        
        if eventModeL.total_population != nil {
             lbAttendPerson.text = eventModeL.total_population
           attendPerson = eventModeL.total_population
        }
       
        if eventModeL.notes_person != nil {
            lbNote.text = eventModeL.notes_person
            notes_person = eventModeL.notes_person
        }
        
        if eventModeL.hide_status == "1" {
            //hide
          //  stackAttaent.isHidden = true
           // lbGoing.isHidden = true
           
            
            if eventModeL.going_person == "0" {
                bYes.isHidden = false
                bEdit.isHidden = true
            } else {
                bYes.isHidden = true
                bEdit.isHidden = false
            }
        } else {
            //hide
          heightButton.constant = 0
            bYes.isHidden = true
            bEdit.isHidden = true
            
        }
        
    }
    

    @IBAction func onClickBAck(_ sender: Any) {
        doPopBAck()
    }
    
    @IBAction func onClickYes(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "idAttendEventVC") as! AttendEventVC
        
            vc.attendPerson = attendPerson
            vc.noOfAttent = notes_person
             vc.event_id = eventModeL.event_id
            vc.isShowDelet = false
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    @IBAction func onClickEdit(_ sender: Any) {
          let vc = storyboard?.instantiateViewController(withIdentifier: "idAttendEventVC") as! AttendEventVC
        vc.attendPerson = attendPerson
        vc.note = notes_person
        vc.event_id = eventModeL.event_id
        vc.isShowDelet = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
