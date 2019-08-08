//
//  BillAndFundDetailsVC.swift
//  Finca
//
//  Created by harsh panchal on 14/06/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

class BillAndFundDetailsVC: BaseVC {
    var maintainanceList : Maintenance_Model!
    var billList : Bill_Model!
    var isBillList = false
    @IBOutlet weak var lblBillHolderName: UILabel!
    @IBOutlet weak var lblBillHolderEmail: UILabel!
    @IBOutlet weak var lblpaymentStatus: UILabel!
    @IBOutlet weak var lblMaintenanceFor: UILabel!
    @IBOutlet weak var lblMaintenanceDate: UILabel!
    @IBOutlet weak var lblDueDate: UILabel!
    @IBOutlet weak var lblPaymentDate: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    
    @IBOutlet weak var lbFor: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    @IBOutlet weak var bPayNoew: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(maintainanceList.maintenanceName!)
        lblpaymentStatus.layer.cornerRadius = 10
        lblpaymentStatus.layer.masksToBounds = true
        lblAmount.layer.masksToBounds = true
        lblAmount.layer.cornerRadius = 20
        if isBillList {
            lblBillHolderName.text = doGetLocalDataUser().user_full_name!
            lblBillHolderEmail.text = doGetLocalDataUser().user_email!
            lblMaintenanceFor.text = billList.billName
            lblMaintenanceDate.text = billList.billGenrateDate
            lblDueDate.text = billList.billEndDate
            lblPaymentDate.text = billList.billPaymentDate
            lblDescription.text = billList.billDescription
          //  lblAmount.text = billList.billAmount
            
            
         //   print("reps" ,billList )
            lbFor.text = "Bill For"
            lbDate.text = "Bill Date"
            if billList.receiveBillStatus == "2" {
                lblAmount.text = billList.billAmount
                bPayNoew.backgroundColor = ColorConstant.colorP
            } else {
                 lblAmount.text = billList.billAmount
                lblpaymentStatus.text = "Paid"
                lblpaymentStatus.backgroundColor = ColorConstant.green400
                bPayNoew.setTitle("DOWNLOAD", for: .normal)
                bPayNoew.backgroundColor = ColorConstant.red500
            }
            
            
        }else{
         
            lblBillHolderName.text = doGetLocalDataUser().user_full_name!
            lblBillHolderEmail.text = doGetLocalDataUser().user_email!
            lblMaintenanceFor.text = maintainanceList.maintenanceName
            lblMaintenanceDate.text = maintainanceList.createdDate
            lblDueDate.text = maintainanceList.endDate
            lblPaymentDate.text = maintainanceList.receiveMaintenanceDate
            lblDescription.text = maintainanceList.maintenanceDescription
            lblAmount.text = maintainanceList.maintenceAmount
            
            bPayNoew.backgroundColor = ColorConstant.colorP
            lbFor.text = "Fund For"
            lbDate.text = "Fund Date"
            
            if maintainanceList.receiveMaintenanceStatus == "0" {
                //unpain
                //cell.lblExpense.textColor = ColorConstant.red400
                
                  bPayNoew.backgroundColor = ColorConstant.colorP
                
            } else {
                lblAmount.text = maintainanceList.maintenceAmount
                lblpaymentStatus.text = "Paid"
                lblpaymentStatus.backgroundColor = ColorConstant.green400
                bPayNoew.setTitle("DOWNLOAD", for: .normal)
                bPayNoew.backgroundColor = ColorConstant.red500
                
               // cell.lblExpense.textColor = ColorConstant.green400
            }
            
        }
       
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func btnPay(_ sender: UIButton) {
        
        if isBillList {
            
        
         if billList.receiveBillStatus == "2" {
            
            
        self.toast(message: "Please contact with your secretary", type: 0)
         } else {
            let link =  UserDefaults.standard.string(forKey: StringConstants.KEY_BASE_URL)! + "apAdmin/paymentReceiptAndroid.php?user_id=" + doGetLocalDataUser().user_id! + "&unit_id=" + doGetLocalDataUser().unit_id + "&type=B&societyid=" + doGetLocalDataUser().society_id! + "&id=" + billList.receiveBillID
            
           let vc = storyboard?.instantiateViewController(withIdentifier: "idInvoiceVC") as! InvoiceVC
            vc.strUrl = link
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        } else {
            
            
            if maintainanceList.receiveMaintenanceStatus == "0" {
                self.toast(message: "Please contact with your secretary", type: 0)
                
            } else {
                let link =  UserDefaults.standard.string(forKey: StringConstants.KEY_BASE_URL)! + "apAdmin/paymentReceiptAndroid.php?user_id=" + doGetLocalDataUser().user_id! + "&unit_id=" + doGetLocalDataUser().unit_id + "&type=M&societyid=" + doGetLocalDataUser().society_id! + "&id=" + maintainanceList.receiveMaintenanceID
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "idInvoiceVC") as! InvoiceVC
                vc.strUrl = link
                self.navigationController?.pushViewController(vc, animated: true)
                // cell.lblExpense.textColor = ColorConstant.green400
            }
            
            
            
            
        }
    }
}
