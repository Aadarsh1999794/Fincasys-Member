//
//  TimeLineTextCell.swift
//  Finca
//
//  Created by harsh panchal on 19/08/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

class TimeLineTextCell: UITableViewCell {

    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblPostDate: UILabel!
    @IBOutlet weak var lblBlockName: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblPostMessafe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
