//
//  ResourcesVC.swift
//  Finca
//
//  Created by anjali on 18/06/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

struct ResponseEmployee : Codable {
    let status : String!// "status" : "200",
    let message : String!// "message" : "Get Employee Type success."
    let employee_Type : [ModelEmployeeType]!
    
}
struct ModelEmployeeType : Codable {
    
    let society_id : String! //"society_id" : "48",
    let emp_type_icon : String! //"emp_type_icon" : "emp_icon\/Maids_1560837068.png",
    let emp_type_status : String! //"emp_type_status" : "0",
    let emp_type_id : String! //"emp_type_id" : "74",
    let emp_type_name : String! // "emp_type_name" : "Maids"
}

class ResourcesVC: BaseVC {
    
    @IBOutlet weak var cvData: UICollectionView!
    @IBOutlet weak var ivSearch: UIImageView!
    @IBOutlet weak var ivClose: UIImageView!
    
    @IBOutlet weak var tfSearch: UITextField!
    let itemCell = "ResourceCell"
    
    var employee_Types = [ModelEmployeeType]()
    var filteredArray = [ModelEmployeeType]()
    
    @IBOutlet weak var bMenu: UIButton!
    
    @IBOutlet weak var viewChatCount: UIView!
    @IBOutlet weak var lbChatCount: UILabel!
    @IBOutlet weak var viewNotiCount: UIView!
    @IBOutlet weak var lbNotiCount: UILabel!
    
    @IBOutlet weak var viewNoData: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvData.delegate = self
        cvData.dataSource = self
        viewNoData.isHidden = true
        let inb = UINib(nibName: itemCell, bundle: nil)
        cvData.register(inb, forCellWithReuseIdentifier: itemCell)
        
        // Do any additional setup after loading the view.
        doGetEmployes()
        doInintialRevelController(bMenu: bMenu)
        ivSearch.setImageColor(color: ColorConstant.colorP)
        ivClose.setImageColor(color: ColorConstant.colorP)
         tfSearch.delegate = self
        tfSearch.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    ivClose.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNoti()
    }
    
    
    @objc func textFieldDidChange(textField: UITextField) {
        
        //your code
        
            filteredArray = textField.text!.isEmpty ? employee_Types : employee_Types.filter({ (item:ModelEmployeeType) -> Bool in
                
                return item.emp_type_name.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil) != nil
            })
        
        if textField.text == "" {
            self.ivClose.isHidden  = true
        } else {
            self.ivClose.isHidden  = false
        }
        
       hideView()
        cvData.reloadData()
       
        
        
    }
    func hideView() {
        
        if filteredArray.count == 0 {
            viewNoData.isHidden = false
            
        } else {
            viewNoData.isHidden = true
            
        }
    }
    
    func doGetEmployes() {
        showProgress()
        //let device_token = UserDefaults.standard.string(forKey: ConstantString.KEY_DEVICE_TOKEN)
        let params = ["key":apiKey(),
                      "getEmployeeType":"getEmployeeType",
                      "society_id":doGetLocalDataUser().society_id!]
        
        
        print("param" , params)
        
        let requrest = AlamofireSingleTon.sharedInstance
        
        
        requrest.requestPost(serviceName: ServiceNameConstants.employeeTypeController, parameters: params) { (json, error) in
            
            if json != nil {
                self.hideProgress()
                do {
                    let response = try JSONDecoder().decode(ResponseEmployee.self, from:json!)
                    
                    
                    if response.status == "200" {
                        self.employee_Types.append(contentsOf: response.employee_Type)
                        self.filteredArray = self.employee_Types
                        self.cvData.reloadData()
                        self.viewNoData.isHidden = true
                        
                    }else {
                         self.viewNoData.isHidden = false
                        self.showAlertMessage(title: "Alert", msg: response.message)
                    }
                } catch {
                    print("parse error")
                }
            }
        }
        
    }
    
    func loadNoti() {
        let vc = BaseVC()
        if vc.getChatCount() !=  "0" {
            self.viewChatCount.isHidden =  false
            self.lbChatCount.text = vc.getChatCount()
            
        } else {
            self.viewChatCount.isHidden =  true
        }
        if vc.getNotiCount() !=  "0" {
            self.viewNotiCount.isHidden =  false
            self.lbNotiCount.text = vc.getNotiCount()
            
        } else {
            self.viewNotiCount.isHidden =  true
        }
    }
    
    @IBAction func onClickNotification(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "idNotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onClickChat(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "idTabCarversionVC") as! TabCarversionVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    @IBAction func onClickClearText(_ sender: Any) {
        tfSearch.text = ""
        
        filteredArray = employee_Types
        cvData.reloadData()
        view.endEditing(true)
        ivClose.isHidden = true
        hideView()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      ivClose.isHidden = false
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         ivClose.isHidden = true
        return view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
     }
    
   
}
extension  ResourcesVC :   UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCell, for: indexPath) as! ResourceCell
        
            cell.lbTitle.text = filteredArray[indexPath.row].emp_type_name
            Utils.setImageFromUrl(imageView: cell.ivImage, urlString: filteredArray[indexPath.row].emp_type_icon)
            
        
        
         // cell.lbNumber.text =  myParkings[indexPath.row].vehicle_no
        return  cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return filteredArray.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        //if
        let yourWidth = collectionView.bounds.width
        return CGSize(width: yourWidth - 5, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "idResourceEmployeeListVC") as! ResourceEmployeeListVC
            vc.emp_type_id = filteredArray[indexPath.row].emp_type_id
            
       
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
}
