//
//  ExpectedFragmentVC.swift
//  Finca
//
//  Created by harsh panchal on 17/06/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import EzPopup
class ExpectedFragmentVC: BaseVC {
    var exp_visitor_list = [Exp_Visitor_Model]()
    var itemCell = "ExpectedVisitorCell"
    
    @IBOutlet weak var lbNoData: UILabel!
    
    @IBOutlet weak var tbvExpectedVisitor: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbNoData.isHidden = true
        
       
        
        let nib = UINib(nibName: itemCell, bundle: nil)
        tbvExpectedVisitor.register(nib, forCellReuseIdentifier: itemCell)
        tbvExpectedVisitor.delegate = self
        tbvExpectedVisitor.dataSource = self
         NotificationCenter.default.addObserver(self, selector: #selector(callRefreshData(_:)), name: Notification.Name(rawValue:StringConstants.KEY_NOTIFICATION_VISITOR), object: nil)
        
        addRefreshControlTo(tableView: tbvExpectedVisitor)
        doGetExpectedVisitorList()
        
    }
    
    override func fetchNewDataOnRefresh() {
       // exp_visitor_list.removeAll()
        doGetExpectedVisitorList()
        refreshControl.endRefreshing()
    }
    
    
    @IBAction func btnAddExpectedVisitor(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(StringConstants.KEY_NOTIFICATION_VISITOR), object: nil)
        
     /*   let vc = self.storyboard?.instantiateViewController(withIdentifier: "idDailogFamilyMember") as! DailogFamilyMember
        vc.isEmergancy = true
        vc.isProfile = false
        vc.ownedDataSelectVC = self
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.addChild(vc)
        self.view.addSubview(vc.view)*/
        
    }
    @objc func callRefreshData(_ notification: Notification){
        refreshTbv()
       
    }
    func refreshTbv(){
       // exp_visitor_list.removeAll()
        // tbvExpectedVisitor.reloadData()
        doGetExpectedVisitorList()
    }
    func doGetExpectedVisitorList()  {
        if exp_visitor_list.count > 0 {
             exp_visitor_list.removeAll()
            tbvExpectedVisitor.reloadData()
        }
        
        showProgress()
        
        let params = ["key":ServiceNameConstants.API_KEY,
                      "getExVisitorList":"getExVisitorList",
                      "society_id":doGetLocalDataUser().society_id!,
                      "user_id":doGetLocalDataUser().user_id!]
        
        print("param" , params)
        
        let request = AlamofireSingleTon.sharedInstance
        
        request.requestPost(serviceName: ServiceNameConstants.VISITOR_CONTROLLER, parameters: params) { (json, error) in
            self.hideProgress()
            
            if json != nil {
                
                do {
                    
                    let response = try JSONDecoder().decode(ExpectedVisitorResponse.self, from:json!)
                    if response.status == "200" {
                        self.lbNoData.isHidden = true
                        self.exp_visitor_list.append(contentsOf: response.visitor)
                        self.tbvExpectedVisitor.reloadData()
                    }else {
                        self.lbNoData.isHidden = false
                    }
                    print(json as Any)
                } catch {
                    print("parse error")
                }
            }
        }
    }
    func doCallDeleteApi(id:String,name:String) {
        showProgress()
        
        let params = ["key":ServiceNameConstants.API_KEY,
                      "deleteVisitor":"deleteVisitor",
                      "visitor_id":id,
                      "user_id":doGetLocalDataUser().user_id!,
                      "user_name":doGetLocalDataUser().user_full_name!,
                      "visitor_name":name,
                      "society_id":doGetLocalDataUser().society_id!]
        
        print("param" , params)
        
        let request = AlamofireSingleTon.sharedInstance
        
        request.requestPost(serviceName: ServiceNameConstants.VISITOR_CONTROLLER, parameters: params) { (json, error) in
            self.hideProgress()
            
            if json != nil {
                
                do {
                    
                    
                    let response = try JSONDecoder().decode(CommonResponse.self, from:json!)
                    if response.status == "200" {
                        self.refreshTbv()
                    }else {

                    }
                    print(json as Any)
                } catch {
                    print("parse error")
                }
            }
        }
    }
    @objc func buttonDeleteClicked(sender:UIButton) {
        doCallDeleteApi(id:exp_visitor_list[sender.tag].visitorID,name:exp_visitor_list[sender.tag].visitorName )
    }
    @objc func buttonEditClicked(sender:UIButton){
//        NotificationCenter.default.post(name: NSNotification.Name(StringConstants.KEY_NOTIFICATION_VISITOR), object: nil)
       // print("sjvavsjvajsva")
        let screenwidth = UIScreen.main.bounds.width
        let screenheight = UIScreen.main.bounds.height
        let destiController = self.storyboard?.instantiateViewController(withIdentifier: "idAddExpMemberDialogVC") as! AddExpMemberDialogVC
        destiController.visitorData = exp_visitor_list[sender.tag]
        destiController.isEditVisitorCalled = true
        
        let popupVC = PopupViewController(contentController: destiController, popupWidth: screenwidth - 50, popupHeight: screenheight-80
        )
        
        popupVC.backgroundAlpha = 0.5
        popupVC.backgroundColor = .black
        popupVC.shadowEnabled = true
     
        popupVC.canTapOutsideToDismiss = false
        present(popupVC, animated: true)
    }
}
extension ExpectedFragmentVC : IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "EXPECTED"
    }
}
extension ExpectedFragmentVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exp_visitor_list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvExpectedVisitor.dequeueReusableCell(withIdentifier: itemCell, for: indexPath)as! ExpectedVisitorCell
        cell.visitorCount(Count: exp_visitor_list[indexPath.row].vistorNumber)
        cell.visitTime(time: exp_visitor_list[indexPath.row].visitTime)
        cell.lblVisitDate.text = exp_visitor_list[indexPath.row].visitDate
        cell.lblVisitorName.text = exp_visitor_list[indexPath.row].visitorName
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(buttonDeleteClicked(sender:)), for: .touchUpInside)
        cell.btnEditVisitorDetail.tag = indexPath.row
        cell.btnEditVisitorDetail.addTarget(self, action: #selector(buttonEditClicked(sender:)), for: .touchUpInside)
        Utils.setImageFromUrl(imageView: cell.imgVisitorProfile, urlString: exp_visitor_list[indexPath.row].visitorProfile)
        
          cell.lblStatus.textColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        switch exp_visitor_list[indexPath.row].visitorStatus {
        case "0":
            cell.lblStatus.text = "Pending"
            cell.lblStatus.backgroundColor =  ColorConstant.pending
            break;
       
        case "2":
            cell.lblStatus.text = "Entered"
            cell.lblStatus.backgroundColor =  ColorConstant.entered
            cell.lblExitTime.isHidden = false
            cell.lblExitDate.isHidden = false
          //  cell.visitTime(time: exp_visitor_list[indexPath.row].visitTime)
           // cell.visitTime(time: exp_visitor_list[indexPath.row].visitTime)
            
            //cell.visitorExitDate(extDate: exp_visitor_list[indexPath.row].exitDate)
           // cell.visitorExitTime(extTime: exp_visitor_list[indexPath.row].exitTime)
            cell.viewEdit.isHidden = true
           
            break;
            
            
        case "3":
            cell.lblStatus.text = "Exited"
            cell.lblStatus.backgroundColor =  ColorConstant.exited
            cell.lblExitTime.isHidden = false
            cell.lblExitDate.isHidden = false
            cell.visitorExitDate(extDate: exp_visitor_list[indexPath.row].exitDate)
            cell.visitorExitTime(extTime: exp_visitor_list[indexPath.row].exitTime)
            cell.btnEditVisitorDetail.isHidden = true
            cell.viewEdit.isHidden = true
        break;
        
        default:
            break
        }
        cell.selectionStyle = .none
        return cell
    }
}
//let destiController = self.storyboard?.instantiateViewController(withIdentifier: "idAddCategoryVC") as! AddCategoryVC
//destiController.CategoryType = "0"
//let popupVC = PopupViewController(contentController: destiController, popupWidth: screenwidth - 20, popupHeight: 150)
//popupVC.backgroundAlpha = 0.5
//popupVC.backgroundColor = .black
//popupVC.shadowEnabled = true
//popupVC.canTapOutsideToDismiss = true
//// show it by call present(_ , animated:) method from a current UIViewController
//present(popupVC, animated: true)
