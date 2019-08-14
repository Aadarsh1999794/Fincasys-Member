//
//  TabMemberConversionVC.swift
//  Finca
//
//  Created by anjali on 19/06/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CenteredCollectionView

class TabMemberConversionVC: BaseVC {
    @IBOutlet weak var cvBlocks: UICollectionView!
    let itemCell = "BlockMemberCell"
    var blocks = [BlockModelMember]()
    var  floors = [FloorModelMember]()
    let itemCellFloor = "FloorSelectionCell"
    
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    
    @IBOutlet weak var cvUnits: UICollectionView!
    var isFirstTimeload = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvBlocks.delegate = self
        cvBlocks.dataSource = self
        
        
        
        
        centeredCollectionViewFlowLayout = cvBlocks.collectionViewLayout as? CenteredCollectionViewFlowLayout
        _ = cvBlocks.bounds.width  / 2
        
        //        return CGSize(width: yourWidth-4, height: 100)
        centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: 60,
            height: 60
        )
        
        cvBlocks.showsVerticalScrollIndicator = false
        cvBlocks.showsHorizontalScrollIndicator = false
        // Modify the collectionView's decelerationRate (REQUIRED STEP)
        cvBlocks.decelerationRate = UIScrollView.DecelerationRate.fast
        
        
        let inb = UINib(nibName: itemCell, bundle: nil)
        cvBlocks.register(inb, forCellWithReuseIdentifier: itemCell)
        
        cvUnits.delegate = self
        cvUnits.dataSource = self
        let inbFloor = UINib(nibName: itemCellFloor, bundle: nil)
        cvUnits.register(inbFloor, forCellWithReuseIdentifier: itemCellFloor)
        
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(clickFloor(_:)),
                                               name: NSNotification.Name(rawValue: "clickFloorChat"),
                                               object: nil)
         doGetSocietes()
      addRefreshControlTo(collectionView: cvUnits)
    }
    override func pullToRefreshData(_ sender: Any) {
        self.blocks.removeAll()
        self.floors.removeAll()
        cvUnits.reloadData()
        cvBlocks.reloadData()
        hidePull()
        
        doGetSocietes()
    }
    
    @objc func clickFloor(_ notification: NSNotification) {
        
        let data =  notification.userInfo?["data"] as? UnitModelMember
        
        if data?.user_id != doGetLocalDataUser().user_id {
            if data?.unit_status == "1" || data?.unit_status == "3" || data?.unit_status == "5"{
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "idChatVC") as! ChatVC
                vc.unitModelMember =  data
                vc.isGateKeeper = false
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        } else {
            showAlertMessage(title: "", msg: "User Access denay")
        }
        
        
    }
    func selectItem(index:Int) {
        
        //blocks
        
        for i in (0..<blocks.count).reversed() {
            if i == index {
                blocks[i].isSelect = true
            } else {
                blocks[i].isSelect = false
            }
            
        }
        
        cvBlocks.reloadData()
        
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
                        
                        self.blocks.append(contentsOf: response.block)
                       self.cvBlocks.reloadData()
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
    func setDataUtnit(floors:[FloorModelMember]) {
        
        print("dhsdhshdg")
        
        if self.floors.count > 0 {
            self.floors.removeAll()
            cvUnits.reloadData()
        }
        
        self.floors.append(contentsOf: floors)
        cvUnits.reloadData()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.reloadInputViews()
        
        print("sbfjjfb")
        
        
    }
}
extension TabMemberConversionVC : IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Members")
    }
    
}
extension TabMemberConversionVC :  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvUnits {
            return  floors.count
        }
        
        return  blocks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == cvUnits {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellFloor, for: indexPath) as! FloorSelectionCell
            
            cell.lbTitle.text = floors[indexPath.row].floor_name
            cell.doSetDataMember(units: floors[indexPath.row].units, isMember: true)
            cell.setConversion(isConversoin: true)
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCell, for: indexPath) as! BlockMemberCell
        
        cell.lbTitle.text = blocks[indexPath.row].block_name
        
        
        
        
        if blocks[indexPath.row].isSelect {
            // cell.viewTest.backgroundColor = ColorConstant.primaryColor
            cell.viewTest.isHidden = false
            cell.viewUnselect.isHidden = true
            
        //    cell.lbTitle.textColor = UIColor.white
        } else {
            //  setGradintColor(viewGradint: cell.viewTest , color: [ColorConstant.startBlockUnselect.cgColor,ColorConstant.endBlockUnselect.cgColor])
            cell.viewTest.isHidden = true
            cell.viewUnselect.isHidden = false
            
            //  cell.viewTest.backgroundColor = UIColor(named: "gray_20")
           // cell.lbTitle.textColor = ColorConstant.colorGray90
        }
        
         cell.layer.cornerRadius = cell.bounds.height/2
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cvUnits {
            var height = 0
            
            if floors.count > 0 {
                let count = floors[indexPath.row].units.count
                
                if   count % 2 == 0 {
                    let subcount = count / 4
                    print("sub",subcount)
                    height = height +   (130 * subcount)
                } else {
                    let subcount = count / 4
                    
                    height =  (130 * subcount)  + height
                }
            }
            let yourWidth = collectionView.bounds.width
            return CGSize(width: yourWidth-4, height: CGFloat(height))
        }
        
        return CGSize(width: 60, height: 60)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == cvBlocks {
           // let selectedCell = collectionView.cellForItem(at: indexPath) as! BlockMemberCell
            let currentCenteredPage = centeredCollectionViewFlowLayout.currentCenteredPage
            if currentCenteredPage != indexPath.row {
                // trigger a scrollToPage(index: animated:)
                centeredCollectionViewFlowLayout.scrollToPage(index: indexPath.row, animated: true)
            }
            self.setDataUtnit(floors: blocks[indexPath.row].floors)
          //  isFirstTimeload = false
            selectItem(index: indexPath.row)
        }
        
        
        
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
     //   print("Current centered index: \(String(describing: centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
     //   print(centeredCollectionViewFlowLayout.currentCenteredPage!)
        if blocks.count > 0 {
            self.setDataUtnit(floors: blocks[centeredCollectionViewFlowLayout.currentCenteredPage!].floors)
            
            self.selectItem(index: centeredCollectionViewFlowLayout.currentCenteredPage!)
            
        }
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
      //  print("Current centered index: \(String(describing: centeredCollectionViewFlowLayout.currentCenteredPage ?? nil))")
       // print(centeredCollectionViewFlowLayout.currentCenteredPage!)
        self.selectItem(index: centeredCollectionViewFlowLayout.currentCenteredPage!)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == cvBlocks {
           // let selectedCell = collectionView.cellForItem(at: indexPath) as! BlockMemberCell
          //  selectedCell.viewTest.backgroundColor = ColorConstant.colorGray10
          //  selectedCell.lbTitle.textColor = ColorConstant.colorGray90
         //  isFirstTimeload = false
        }
        
    }
    
}

