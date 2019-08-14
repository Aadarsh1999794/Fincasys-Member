//
//  FloorSelectionCell.swift
//  Finca
//
//  Created by anjali on 01/06/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

class FloorSelectionCell: UICollectionViewCell {
    @IBOutlet weak var cvData: UICollectionView!
    @IBOutlet weak var lbTitle: UILabel!
    //  var units = [Unini]
    let itemCell = "SelectBlockCell"
    let itemCell2 = "FloorMemberCell"
    var units = [UnitModel]()
    var unitsMember = [UnitModelMember]()
    var isMember:Bool!
    
    @IBOutlet weak var viewTest: UIView!
    var isConversoin = false
    
    @IBOutlet weak var viewMain: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbTitle.layer.masksToBounds = true
        cvData.delegate = self
        cvData.dataSource = self
        cvData.alwaysBounceHorizontal = false
        let inb = UINib(nibName: itemCell, bundle: nil)
        cvData.register(inb, forCellWithReuseIdentifier: itemCell)
        
        
        let inb2 = UINib(nibName: itemCell2, bundle: nil)
        cvData.register(inb2, forCellWithReuseIdentifier: itemCell2)
        
       /* let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = ColorConstant.primaryColor.cgColor
        yourViewBorder.lineWidth = 2
        yourViewBorder.lineDashPattern = [7, 3]
       // yourViewBorder.frame = viewTest.frame
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: viewTest.frame).cgPath
//        viewMain.layer.masksToBounds = true
        
        
        viewTest.layer.addSublayer(yourViewBorder)*/
       
      //  viewMain.addDashedLineView(frame: CGRect())
       
        // viewMain.addDashedLineView(frame: CGRect(x: 0, y: 0, width: Int(viewMain.frame.width), height: Int(viewMain.frame.height)))
        
        
       
        cvData.isScrollEnabled = false
        
        
        
    }
    
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//    }
    
    func doSetData(units:[UnitModel],isMember:Bool) {
        
        if units.count > 0 {
            self.units.removeAll()
            cvData.reloadData()
        }
        self.units.append(contentsOf: units)
        self.isMember = isMember
        cvData.reloadData()
    }
    
    func doSetDataMember(units:[UnitModelMember],isMember:Bool) {
        if unitsMember.count > 0 {
            unitsMember.removeAll()
            cvData.reloadData()
        }
        
        self.unitsMember.append(contentsOf: units)
        self.isMember = isMember
     
        if let layout = cvData.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        cvData.reloadData()
    }
    
    func setConversion(isConversoin:Bool) {
        self.isConversoin = isConversoin
        cvData.reloadData()
    }
    
    
    

}


extension FloorSelectionCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isMember {
            return unitsMember.count
        }
        return units.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        
        if isMember {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCell2, for: indexPath) as! FloorMemberCell
            
            
           /// cell.viewMain.layer.cornerRadius = 0.0
            
        /*   if unitsMember[indexPath.row].unit_status == "0" {
            
            print("avilabe" , indexPath.row)
                //avilable
                //cell.viewMain.layer.backgroundColor = ColorConstant.colorEmpty.cgColor
                cell.viewMain.InsideColor = ColorConstant.startEmptyMember
                cell.viewMain.OutsideColor = ColorConstant.endEmptyMember
                
                
            } else if unitsMember[indexPath.row].unit_status == "1" {
            print("onwer" , indexPath.row)
            
                // onwer
               // cell.viewMain.layer.backgroundColor = ColorConstant.colorOwner.cgColor
                cell.viewMain.InsideColor = ColorConstant.startAvilable
                cell.viewMain.OutsideColor = ColorConstant.endAvilable
                
            } else if unitsMember[indexPath.row].unit_status == "2" {
                // defaulter
                //cell.viewMain.layer.backgroundColor = ColorConstant.colorDefaulter.cgColor
                cell.viewMain.InsideColor = ColorConstant.startDefulter
                cell.viewMain.OutsideColor = ColorConstant.endDefulter
            }else if unitsMember[indexPath.row].unit_status == "3" {
                // rent
             //   cell.viewMain.layer.backgroundColor = ColorConstant.colorRent.cgColor
                cell.viewMain.InsideColor = ColorConstant.startRent
                cell.viewMain.OutsideColor = ColorConstant.endRent
                
            } else if unitsMember[indexPath.row].unit_status == "4" {
                // pendeing
                //cell.viewMain.layer.backgroundColor = ColorConstant.colorEmpty.cgColor
                cell.viewMain.InsideColor = ColorConstant.startPending
                cell.viewMain.OutsideColor = ColorConstant.endPending
                
            }else if unitsMember[indexPath.row].unit_status == "5" {
                // close
               // cell.viewMain.layer.backgroundColor = ColorConstant.colorClose.cgColor
                
                cell.viewMain.InsideColor = ColorConstant.startEmptyMember
                cell.viewMain.OutsideColor = ColorConstant.endEmptyMember
                
            }*/
            
            cell.setBackUnit(unit_status: unitsMember[indexPath.row].unit_status)
            cell.lbTitle.text = unitsMember[indexPath.row].unit_name
            cell.lbName.text = unitsMember[indexPath.row].user_full_name
           if isConversoin {
            
            if unitsMember[indexPath.row].chat_status != "0" {
                cell.viewNotification.isHidden = false
                cell.lbCountNoti.text = unitsMember[indexPath.row].chat_status
            } else {
                  cell.viewNotification.isHidden = true
            }
           
            
            }
         
            
            
            return cell
            
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCell, for: indexPath) as! SelectBlockCell
        
        
        cell.viewMain.layer.cornerRadius = 0.0
        
        if units[indexPath.row].unit_status == "0" {
            //avilable
            cell.viewMain.layer.backgroundColor = ColorConstant.colorAvilable.cgColor
            
        } else if units[indexPath.row].unit_status == "1" {
            // onwer
            cell.viewMain.layer.backgroundColor = ColorConstant.colorOwner.cgColor
        } else if units[indexPath.row].unit_status == "2" {
            // defaulter
            cell.viewMain.layer.backgroundColor = ColorConstant.colorDefaulter.cgColor
        }else if units[indexPath.row].unit_status == "3" {
            // rent
            cell.viewMain.layer.backgroundColor = ColorConstant.colorRent.cgColor
        } else if units[indexPath.row].unit_status == "4" {
            // pendeing
            cell.viewMain.layer.backgroundColor = ColorConstant.colorPending.cgColor
        }else if units[indexPath.row].unit_status == "5" {
            // close
            cell.viewMain.layer.backgroundColor = ColorConstant.colorClose.cgColor
        }
        
        
        
        cell.lbTitle.text = units[indexPath.row].unit_name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = 120 / 2
        
        if isMember {
              let yourWidth = viewMain.frame.width / 4
            return CGSize(width: yourWidth - 5 , height: 90)
        }
        return CGSize(width: yourWidth, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if isMember {
            
            if isConversoin {
                NotificationCenter.default.post(
                    name: Notification.Name(rawValue: "clickFloorChat"),
                    object: nil,
                    userInfo: ["data": unitsMember[indexPath.row]])
            } else {
                NotificationCenter.default.post(
                    name: Notification.Name(rawValue: "clickFloor"),
                    object: nil,
                    userInfo: ["data": unitsMember[indexPath.row]])
            }
            
            
            
        } else {
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "clickFloor"),
                object: nil,
                userInfo: ["data": units[indexPath.row]])
        }
        
        
        
    }
}


