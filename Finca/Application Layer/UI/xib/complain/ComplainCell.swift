//
//  ComplainCell.swift
//  Finca
//
//  Created by harsh panchal on 02/07/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

class ComplainCell: UITableViewCell {

    @IBOutlet weak var lblCmpDate: UILabel!
    @IBOutlet weak var lblCmpStatus: UILabel!
    @IBOutlet weak var lblCmpTitle: UILabel!
    @IBOutlet weak var lblCmpDesc: UILabel!
    @IBOutlet weak var lblCmpAdminMsg: UILabel!
    @IBOutlet weak var viewBtnEdit: UIView!
     @IBOutlet weak var viewBtnDelete: UIView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var viewMain: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblCmpStatus.layer.cornerRadius = 5
        lblCmpStatus.layer.masksToBounds = true
        
        viewMain.layer.shadowRadius = 3
        viewMain.layer.shadowOffset = CGSize.zero
        viewMain.layer.shadowOpacity = 0.3
        viewMain.layer.cornerRadius = 5
//        viewMain.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
