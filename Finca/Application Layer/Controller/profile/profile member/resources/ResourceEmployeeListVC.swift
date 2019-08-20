//
//  ResourceEmployeeListVC.swift
//  Finca
//
//  Created by anjali on 18/06/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

struct ResponseEmployeeList : Codable {
    let status : String!// "status" : "200",
    let message : String!// "message" : "Get Employee Type success."
    let employee:[ModelEmployeeList]!
    
}
struct ModelEmployeeList : Codable {
    let emp_status : String!//  "emp_status" : "1",
    let emp_address : String!// "emp_address" : "Test Addsres",
    let emp_type_id : String!// "emp_type_id" : "74",
    let emp_id : String!// "emp_id" : "131",
    let emp_sallary : String!// "emp_sallary" : "120000",
    let emp_name : String!// "emp_name" : "Test Bhai",
    let emp_id_proof : String!//  "emp_id_proof" : "",
    let entry_status : String!//  "entry_status" : "0",
    let emp_date_of_joing : String!// "emp_date_of_joing" : "",
    let emp_mobile : String!// "emp_mobile" : "9823998234",
    let emp_email : String!//  "emp_email" : "",
    let society_id : String!//  "society_id" : "48",
    let emp_profile : String!// "emp_profile" : "http:\/\/www.fincasys.com\/img\/emp\/user.png"
}
class ResourceEmployeeListVC: BaseVC {
    
    @IBOutlet weak var cvData: UICollectionView!
    @IBOutlet weak var tfSearch: UITextField!
    
    let itemCell = "EmployeeListCell"
    var emp_type_id:String!
    var employees = [ModelEmployeeList]()
    var filteredArray = [ModelEmployeeList]()
    @IBOutlet weak var ivSearch: UIImageView!
    @IBOutlet weak var ivClose: UIImageView!
    
    
    @IBOutlet weak var lbNoData: UILabel!
    @IBOutlet weak var bBack: UIButton!
    var shouldShowSearchResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cvData.delegate = self
        cvData.dataSource = self
      //  changeButtonImageColor(btn: bBack, image: "back", color: UIColor.white)
        let inb = UINib(nibName: itemCell, bundle: nil)
        cvData.register(inb, forCellWithReuseIdentifier: itemCell)
        
        ivSearch.setImageColor(color: ColorConstant.colorP)
        ivClose.setImageColor(color: ColorConstant.colorP)
        tfSearch.delegate = self
        tfSearch.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        ivClose.isHidden = true
          lbNoData.isHidden = true
        doGetEmployes()
    }
    func hideView() {
        
        if filteredArray.count == 0 {
            lbNoData.isHidden = false
            
        } else {
            lbNoData.isHidden = true
            
        }
    }
    
    
    @objc func textFieldDidChange(textField: UITextField) {
        
        //your code
        
        filteredArray = textField.text!.isEmpty ? employees : employees.filter({ (item:ModelEmployeeList) -> Bool in
            
            return item.emp_name.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        if textField.text == "" {
            self.ivClose.isHidden  = true
        } else {
            self.ivClose.isHidden  = false
        }
        
        hideView()
         cvData.reloadData()
        
        
        
    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
        doPopBAck()
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //shouldShowSearchResults = true
        
      //  didChangeSearchText(searchText: tfSearch.text!)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       // shouldShowSearchResults = false
     //   cvData.reloadData()
        return view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //shouldShowSearchResults = false
    }
    
    func doGetEmployes() {
        showProgress()
        //let device_token = UserDefaults.standard.string(forKey: ConstantString.KEY_DEVICE_TOKEN)
        let params = ["key":apiKey(),
                      "getEmployee":"getEmployee",
                      "emp_type_id":emp_type_id!,
                      "society_id":doGetLocalDataUser().society_id!,
                      "unit_id":doGetLocalDataUser().unit_id!]
        
        
        print("param" , params)
        
        let requrest = AlamofireSingleTon.sharedInstance
        
        
        requrest.requestPost(serviceName: ServiceNameConstants.employeeListController, parameters: params) { (json, error) in
            
            if json != nil {
                self.hideProgress()
                do {
                    let response = try JSONDecoder().decode(ResponseEmployeeList.self, from:json!)
                    
                    
                    if response.status == "200" {
                        self.employees.append(contentsOf: response.employee)
                        self.filteredArray = self.employees
                        self.cvData.reloadData()
                         self.lbNoData.isHidden = true
                    }else {
                        self.showAlertMessage(title: "Alert", msg: response.message)
                         self.lbNoData.isHidden = false
                    }
                } catch {
                    print("parse error")
                }
            }
        }
        
    }
    
    @objc func onClickOnCall(sender:UIButton) {
        
        let index = sender.tag
        
        if filteredArray[index].entry_status == "1" {
            // avilabe
            print("clcicl" , index)
            
            let phone = employees[index].emp_mobile!
            if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
            
        }else {
            // not
       showAlertMessage(title: "", msg: "Not Available")
            
        }
        
        
       
    }
    
    
    
    @IBAction func onClickClearText(_ sender: Any) {
        tfSearch.text = ""
        
        filteredArray = employees
        cvData.reloadData()
        view.endEditing(true)
        ivClose.isHidden = true
         hideView()
    }
    
    
}
extension  ResourceEmployeeListVC :   UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCell, for: indexPath) as! EmployeeListCell
        
            cell.lbName.text = filteredArray[indexPath.row].emp_name
            
            Utils.setImageFromUrl(imageView: cell.ivImage, urlString: filteredArray[indexPath.row].emp_profile)
            // cell.lbNumber.text =  myParkings[indexPath.row].vehicle_no
            
            if filteredArray[indexPath.row].entry_status == "1" {
                // avilabe
                cell.lbStatus.text = "Available"
                cell.lbStatus.textColor = ColorConstant.green500
            }else {
                // not
                cell.lbStatus.text = "Not Available"
                cell.lbStatus.textColor = ColorConstant.red500
            }
      
        
        cell.bCall.tag = indexPath.row
        cell.bCall.addTarget(self, action: #selector(onClickOnCall(sender:)), for: .touchUpInside)
        return  cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
              return filteredArray.count
       
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        //if
        let yourWidth = collectionView.bounds.width
        return CGSize(width: yourWidth - 5, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 4
    }
    
}
