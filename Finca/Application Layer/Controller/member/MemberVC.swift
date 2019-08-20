//
//  MemberVC.swift
//  Finca
//
//  Created by anjali on 12/06/19.
//  Copyright © 2019 anjali. All rights reserved.
//
import UIKit
import CenteredCollectionView
struct ResponseMember : Codable {
    
    var population:Int! // "population" : 1,
    var message:String!  //"message" : "Get Member success.",
    var status:String! //"status" : "200"
    var block : [BlockModelMember]!
}
struct BlockModelMember : Codable {
    var block_status:String! //"block_status" : "0",
    var block_name:String!// "block_name" : "A",
    var block_id:String! //"block_id" : "126",
    var society_id:String!  //"society_id" : "48"
    var isSelect:Bool!  //"society_id" : "48"
    var  floors : [FloorModelMember]!
    
}
struct FloorModelMember : Codable {
    var floor_name:String! //"floor_name" : "1 Floor",
    var society_id:String! //"society_id" : "48",
    var floor_status:String! //"floor_status" : "0",
    var block_id:String!// "block_id" : "126",
    var floor_id:String!  //"floor_id" : "518"
    var  units : [UnitModelMember]!
    
}
struct UnitModelMember : Codable {
    var user_unit_id:String! //"user_unit_id" : null,
    var user_mobile:String! //"user_mobile" : null,
    var user_email:String! //"user_email" : null,
    var user_type:String! //"user_type" : null,
    var user_floor_id:String! //"user_floor_id" : null,
    var unit_name:String! //"unit_name" : "101",
    var user_last_name:String! //"user_last_name" : null,
    var user_status:String! //"user_status" : null,
    var user_block_id:String! //"user_block_id" : null,
    var user_id_proof:String! //"user_id_proof" : null,
    var user_full_name:String! //"user_full_name" : null,
    var floor_id:String! //"floor_id" : "518",
    var chat_status:String! //"chat_status" : "0",
    var unit_status:String!  //"unit_status" : "0",
    var unit_type:String!  //"unit_type" : null,
    var unit_id:String! //"unit_id" : "2118",
    var user_profile_pic:String! //"user_profile_pic" : ".com\/img\/users\/
    var society_id:String! //"society_id" : null,
    var family_count:String! //"family_count" : "1",
    var user_id:String!//"user_id" : null,
    var user_first_name:String! //"user_first_name" : null
    
    var about_business : String! //about_business
    var myParking:[MyParkingModelMember]!
    
}
struct MyParkingModelMember : Codable {
    var sociaty_id:String! //"sociaty_id" : null,
    var parking_name:String! // "parking_name" : "C-1",
    var unit_id:String! //"unit_id" : "2119",
    var society_parking_id:String!  //"society_parking_id" : "49",
    var vehicle_no:String! // "vehicle_no" : "Ground1-C-1 - gj 01 hu 420",
    var parking_id:String! // "parking_id" : "1645",
    var block_id:String! // "block_id" : "126",
    var parking_type:String!// "parking_type" : "0",
    var floor_id:String!  //"floor_id" : "518",
    var parking_status:String! //"parking_status" : "1"
    
}
class MemberVC: BaseVC {
    @IBOutlet weak var viewSelectorSlot: UIView!
    @IBOutlet weak var cvBlock: UICollectionView!
    @IBOutlet weak var cvUnits: UICollectionView!
    @IBOutlet weak var lbBlock: UILabel!
    @IBOutlet weak var lbPopulation: UILabel!
    @IBOutlet weak var bMenu: UIButton!
    
    let itemCell = "BlockMemberCell"
    let itemCellFloor = "FloorSelectionCell"
    
    var blocks = [BlockModelMember]()
    var  floors = [FloorModelMember]()
    var isFirstTimeload = true
    
    @IBOutlet weak var viewChatCount: UIView!
    @IBOutlet weak var lbChatCount: UILabel!
    @IBOutlet weak var viewNotiCount: UIView!
    @IBOutlet weak var lbNotiCount: UILabel!
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSelectorSlot.layer.borderColor = #colorLiteral(red: 0.3960784314, green: 0.2235294118, blue: 0.4549019608, alpha: 1)
        viewSelectorSlot.layer.borderWidth = 2
        centeredCollectionViewFlowLayout = cvBlock.collectionViewLayout as! CenteredCollectionViewFlowLayout
        let yourWidth = cvBlock.bounds.width  / 2
        //        return CGSize(width: yourWidth-4, height: 100)
        centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: 60,
            height: 60
        )
        cvBlock.showsVerticalScrollIndicator = false
        cvBlock.showsHorizontalScrollIndicator = false
        // Modify the collectionView's decelerationRate (REQUIRED STEP)
        cvBlock.decelerationRate = UIScrollView.DecelerationRate.fast
        // Do any additional setup after loading the view.
        cvBlock.delegate = self
        cvBlock.dataSource = self
        let inb = UINib(nibName: itemCell, bundle: nil)
        cvBlock.register(inb, forCellWithReuseIdentifier: itemCell)
        
        cvUnits.delegate = self
        cvUnits.dataSource = self
        let inbFloor = UINib(nibName: itemCellFloor, bundle: nil)
        cvUnits.register(inbFloor, forCellWithReuseIdentifier: itemCellFloor)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(clickFloor(_:)),
                                               name: NSNotification.Name(rawValue: "clickFloor"),
                                               object: nil)
        
        doGetSocietes()
        
        doInintialRevelController(bMenu: bMenu)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNoti()
    }
    func loadNoti() {
        
        if getChatCount() !=  "0" {
            self.viewChatCount.isHidden =  false
            self.lbChatCount.text = getChatCount()
            
        } else {
            self.viewChatCount.isHidden =  true
        }
        if getNotiCount() !=  "0" {
            self.viewNotiCount.isHidden =  false
            self.lbNotiCount.text = getNotiCount()
            
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
    
    
    @objc func clickFloor(_ notification: NSNotification) {
        
        let data =  notification.userInfo?["data"] as? UnitModelMember
        
        if data?.user_id != doGetLocalDataUser().user_id {
            if data?.unit_status == "1" || data?.unit_status == "3" || data?.unit_status == "5" {
               
                if let encoded = try? JSONEncoder().encode(data) {
                    UserDefaults.standard.set(encoded, forKey: StringConstants.MEMBER_DETAILS_KEY)
                }
                doCallApiForMemberDetails(selected_residentID: data?.user_id)
                
                //  revealViewController().pushFrontViewController(vc, animated: true)
            }
        }
    }
    func doCallApiForMemberDetails(selected_residentID:String!){
        showProgress()
        //let device_token = UserDefaults.standard.string(forKey: ConstantString.KEY_DEVICE_TOKEN)
        let params = ["key":apiKey(),
                      "getProfileData":"getProfileData",
                      "user_id":selected_residentID!]
        
        
        print("param" , params)
        
        let requrest = AlamofireSingleTon.sharedInstance
        
        
        requrest.requestPost(serviceName: NetworkAPI.memberDetailController, parameters: params) { (json, error) in
            
            if json != nil {
                print(json as Any)
                self.hideProgress()
                do {
                    let response = try JSONDecoder().decode(MemberDetailResponse.self, from:json!)
                    if response.status == "200" {
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "idMemberDetailVC") as! MemberDetailVC
                        vc.memMainResponse = response
                        self.navigationController?.pushViewController(vc, animated: true)
//                        self.emergencyDetails.append(contentsOf: response.emergency)
//                        self.parkingDetails.append(contentsOf: response.myParking)
//                        self.familyMemberDetails.append(contentsOf: response.member)
//                        self.memResponse = response
//                        self.lbName.text = response.userFullName
//                        self.lblTotalParkingCount.text = "\(response.myParking.count)"
//                        self.lblFamilyMemberCount.text = "\(response.member.count)"
//                        Utils.setImageFromUrl(imageView: self.ivProfile, urlString: response.userProfilePic)
//                        Utils.setRoundImageWithBorder(imageView: self.ivProfile, color: UIColor.white)
//                        if response.userType == "0"{
//                            self.lblResidentType.text = "Owner"
//                        }else if response.userType == "1"{
//                            self.lblResidentType.text = "Tenant"
//                        }
//                        self.doCreateActionSheetForFamilyMembers()
                    }else {
                        
                    }
                } catch {
                    print("parse error")
                }
            }
        }
    }
    func selectItem(index:Int) {
        
        //blocks
        print(index)
        for i in (0..<blocks.count) {
            
            if i == index {
                blocks[i].isSelect = true
            } else {
                blocks[i].isSelect = false
            }
        }
        cvBlock.reloadData()
        
    }
    
    
    func setDataUtnit(floors:[FloorModelMember]) {
        
        print("dhsdhshdg")
        
        if self.floors.count > 0 {
            self.floors.removeAll()
            cvUnits.reloadData()
        }
        
        self.floors.append(contentsOf: floors)
        cvUnits.reloadData()
        
    }
    
    func doGetSocietes() {
        showProgress()
        //let device_token = UserDefaults.standard.string(forKey: ConstantString.KEY_DEVICE_TOKEN)
        let params = ["key":apiKey(),
                      "getMembers":"getMembers",
                      "society_id":doGetLocalDataUser().society_id!,
                      "my_id":doGetLocalDataUser().user_id!]
        
        
        print("param" , params)
        
        let requrest = AlamofireSingleTon.sharedInstance
        
        
        requrest.requestPost(serviceName: NetworkAPI.blockListController, parameters: params) { (json, error) in
            
            if json != nil {
                self.hideProgress()
                do {
                    let response = try JSONDecoder().decode(ResponseMember.self, from:json!)
                    
                    
                    if response.status == "200" {
                        
                        //   self.societyArray.append(contentsOf: response.society)
                        //  self.cvData.reloadData()
                        self.lbBlock.text = "Total Block: " + String(response.block.count)
                        self.lbPopulation.text = "Total Residents: " + String(response.population)
                        
                        self.blocks.append(contentsOf: response.block)
                        self.cvBlock.reloadData()
                        self.setDataUtnit(floors: self.blocks[0].floors)
                        self.selectItem(index: 0)
                    }else {
                        self.showAlertMessage(title: "Alert", msg: response.message)
                    }
                } catch {
                    print("parse error")
                }
            }
        }
        
    }
    
    
    
}
extension MemberVC :  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvUnits {
            return  floors.count
        }
        
        return  blocks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == cvUnits {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellFloor, for: indexPath) as! FloorSelectionCell
            
//            cell.lbTitle.text =
            let floor = floors[indexPath.row].floor_name
            
            let floorNoText = ""
            if  floors[indexPath.row].floor_name.contains("floor") {
                let splited = floor?.components(separatedBy: " ")
                let number = splited?[0]
                let text = splited?[1]
                print(number)
                print(text)
//                if splited[0].equalsIgnoreCase("1") {
//                    floorNoText = "1st Floor";
//                } else if splited[0].equalsIgnoreCase("2") {
//                    floorNoText = "2nd Floor";
//                } else if splited[0].equalsIgnoreCase("3") {
//                    floorNoText = "3rd Floor";
//                } else if splited[0].equalsIgnoreCase("12") {
//                    floorNoText = "12th Floor";
//                }else if splited[0].equalsIgnoreCase("13") {
//                    floorNoText = "13th Floor";
//                } else if (splited[0].length() >= 2) {
//                    String str3 = String.valueOf(splited[0].charAt(1));
//                    if (String.valueOf(splited[0].charAt(1)).equalsIgnoreCase("3")) {
//                        floorNoText = String.valueOf(splited[0].charAt(0)) + String.valueOf(splited[0].charAt(1)) + "rd Floor";
//                    }
//                    if (String.valueOf(splited[0].charAt(1)).equalsIgnoreCase("2")) {
//                        floorNoText = String.valueOf(splited[0].charAt(0)) + String.valueOf(splited[0].charAt(1)) + "nd Floor";
//                    }
//                } else {
//                    floorNoText = splited[0] + "th Floor";
//                }
//                myViewHolder.floor.setText("" + floorNoText);
//            } else {
//                myViewHolder.floor.setText("" + list.get(i).getFloorName());
            }
//

            cell.doSetDataMember(units: floors[indexPath.row].units, isMember: true)
//            cell.viewMain.addDashedBorder()
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCell, for: indexPath) as! BlockMemberCell
        
        cell.lbTitle.text = blocks[indexPath.row].block_name
        
        // cell.lbTitle.textColor = UIColor.white
        
        if blocks[indexPath.row].isSelect {
            // cell.viewTest.backgroundColor = ColorConstant.primaryColor
            cell.viewTest.backgroundColor = UIColor(named: "ColorPrimary")
            cell.lbTitle.textColor = UIColor.white
        } else {
            
            cell.viewTest.backgroundColor = UIColor(named: "gray_20")
            cell.lbTitle.textColor = ColorConstant.colorGray90
        }
        
        
        cell.layer.cornerRadius = cell.bounds.height/2
//        cell.viewMain.addDashedBorder()
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cvUnits {
            let yourWidth = collectionView.bounds.width
            return CGSize(width: yourWidth-4, height: 100)
        }
        
        return CGSize(width: 60, height: 60)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == cvBlock {
            /* let selectedCell = collectionView.cellForItem(at: indexPath) as! BlockMemberCell
             
             selectedCell.viewTest.backgroundColor = ColorConstant.primaryColor
             selectedCell.lbTitle.textColor = UIColor.white
             
             isFirstTimeload = false*/
            
            let currentCenteredPage = centeredCollectionViewFlowLayout.currentCenteredPage
            if currentCenteredPage != indexPath.row {
                // trigger a scrollToPage(index: animated:)
                centeredCollectionViewFlowLayout.scrollToPage(index: indexPath.row, animated: true)
            }
            self.setDataUtnit(floors: blocks[indexPath.row].floors)
            selectItem(index: indexPath.row)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Current centered index: \(String(describing: centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
        print(centeredCollectionViewFlowLayout.currentCenteredPage!)
        self.selectItem(index: centeredCollectionViewFlowLayout.currentCenteredPage!)
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("Current centered index: \(String(describing: centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
        print(centeredCollectionViewFlowLayout.currentCenteredPage!)
        self.selectItem(index: centeredCollectionViewFlowLayout.currentCenteredPage!)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        /* if collectionView == cvBlock {
         let selectedCell = collectionView.cellForItem(at: indexPath) as! BlockMemberCell
         selectedCell.viewTest.backgroundColor = ColorConstant.colorGray10
         selectedCell.lbTitle.textColor = ColorConstant.colorGray90
         isFirstTimeload = false
         }*/
        
    }
    
}
