//
//  EventsVC.swift
//  Finca
//
//  Created by anjali on 03/07/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

struct ResponseEvent : Codable{
    let message:String!//" : "Get event success.",
    let status:String!//" : "200"
    let event:[ModelEvent]!
    let event_completed:[ModelEvent]!
    
}

struct ModelEvent : Codable {
     let notes_person:String! //"notes_person" : "noting",
    let numberof_person:String!// "numberof_person" : "5"
    let event_upcoming_completed : String! //" : "0",
    let event_start_date : String! //" : "2019-03-23 10:00 AM",
    let event_id : String! //" : "6",
    let event_end_date : String! //" : "2019-03-23 01:37 PM",
    let going_person : String! //" : "1",
    let event_title : String! //" : "Holi Celebration",
    let hide_status : String! //" : "0",
    let total_population : String! //" : "5",
    let event_image : String! //" : "https:\/\/www.fincasys.com\/img\/event_image\/holi.jpg",
    let event_description : String! //" : "festival of colors"
    let booked_by : String!
    
}

class EventsVC: BaseVC {
    @IBOutlet weak var bMenu: UIButton!
    @IBOutlet weak var cvData: UICollectionView!
    @IBOutlet weak var viewChatCount: UIView!
    @IBOutlet weak var lbChatCount: UILabel!
    @IBOutlet weak var viewNotiCount: UIView!
    @IBOutlet weak var lbNotiCount: UILabel!
    
    @IBOutlet weak var viewUpcoming: UIView!
    @IBOutlet weak var viewCompleted: UIView!
   
    
    @IBOutlet weak var ivUpcoming: UIImageView!
    @IBOutlet weak var ivCompleted: UIImageView!
    
    
    
    let itemCell = "EventCell"
    var eventList = [ModelEvent]()
     var eventComplitedList = [ModelEvent]()
    var isUpcoming = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doInintialRevelController(bMenu: bMenu)
        
        cvData.delegate = self
        cvData.dataSource = self
        
        let inb = UINib(nibName: itemCell, bundle: nil)
        cvData.register(inb, forCellWithReuseIdentifier: itemCell)
        
        
        ivUpcoming.setImageColor(color: .white)
        ivCompleted.setImageColor(color: .white)
      //  doEvent()
        setSelectorEvent(selection: 1)
    
    }
    
    func setSelectorEvent(selection:Int) {
        
        switch selection {
        case 1:
            //upcoming
            viewUpcoming.backgroundColor = ColorConstant.colorP
            viewCompleted.backgroundColor = ColorConstant.gary_60
            isUpcoming = true
            cvData.reloadData()
            cvData.setContentOffset(.zero, animated: true)
        case 2:
            // compltetes
            viewUpcoming.backgroundColor = ColorConstant.gary_60
            viewCompleted.backgroundColor = ColorConstant.colorP
             isUpcoming = false
            cvData.reloadData()
            cvData.setContentOffset(.zero, animated: true)
        default:
            break
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadNoti()
        
        
        if eventList.count > 0 {
            eventList.removeAll()
            eventComplitedList.removeAll()
            cvData.reloadData()
        }
        if eventComplitedList.count > 0 {
            eventComplitedList.removeAll()
            cvData.reloadData()
            
        }
            
        doEvent()
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
    
    func doEvent() {
        showProgress()
        //let device_token = UserDefaults.standard.string(forKey: ConstantString.KEY_DEVICE_TOKEN)
        let params = ["key":apiKey(),
                      "getEventList":"getEventList",
                      "user_id":doGetLocalDataUser().user_id!,
                      "society_id":doGetLocalDataUser().society_id!,
                      "unit_id":doGetLocalDataUser().unit_id!]
        
        
        print("param" , params)
        
        let requrest = AlamofireSingleTon.sharedInstance
        
        
        requrest.requestPost(serviceName: ServiceNameConstants.userEventController, parameters: params) { (json, error) in
             self.hideProgress()
            if json != nil {
               
                do {
                    let response = try JSONDecoder().decode(ResponseEvent.self, from:json!)
                    
                    
                    if response.status == "200" {
                        self.eventList.append(contentsOf: response.event)
                    self.eventComplitedList.append(contentsOf: response.event_completed)
                        self.cvData.reloadData()
                        
                    }else {
                        self.showAlertMessage(title: "Alert", msg: response.message)
                    }
                } catch {
                    print("parse error")
                }
            }
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
    
    
    @IBAction func onClickCompleted(_ sender: Any) {
        setSelectorEvent(selection: 2)
        
    }
    
    @IBAction func onClickUpcoming(_ sender: Any) {
        setSelectorEvent(selection: 1)
        
    }
    
}


extension  EventsVC :   UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCell, for: indexPath) as! EventCell
      //  cell.lbAttending.text = ""
        
        
       if isUpcoming {
        cell.lbTitle.text = eventList[indexPath.row].event_title
        cell.lbDesc.text = eventList[indexPath.row].event_description
        // cell.lbDate.text = eventList[indexPath.row].event_start_date
        
        if eventList[indexPath.row].going_person == "0" {
            cell.lbAttending.text = "Yes"
            cell.lbAttending.textColor = UIColor(named: "green_a700")
        } else {
            cell.lbAttending.text = "NO"
            cell.lbAttending.textColor = UIColor(named: "red_a700")
            
        }
        
        
        //let date = eventList[indexPath.row].event_start_date
        let time = eventList[indexPath.row].event_start_date!.split{$0 == " "}.map(String.init)
        
        cell.lbDate.text = time[1] + time[2]
        
        let date = convertDateFormater(time[0]).split{$0 == "-"}.map(String.init)
        
        cell.lbDay.text = date[2]
        cell.lbMonth.text = date[1] + ","
        cell.lbYear.text = date[0]
        
        Utils.setImageFromUrl(imageView: cell.ivImageEvent, urlString: eventList[indexPath.row].event_image)
       } else {
        
        cell.lbTitle.text = eventComplitedList[indexPath.row].event_title
        
        let time = eventComplitedList[indexPath.row].event_start_date!.split{$0 == " "}.map(String.init)
        
        
        
        let date = convertDateFormater(time[0]).split{$0 == "-"}.map(String.init)
        
        cell.lbDay.text = date[2]
        cell.lbMonth.text = date[1] + ","
        cell.lbYear.text = date[0]
        
                Utils.setImageFromUrl(imageView: cell.ivImageEvent, urlString: eventComplitedList[indexPath.row].event_image)
        
        }
     
        
        
        return  cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isUpcoming {
             return eventList.count
        }else {
             return eventComplitedList.count
        }
       
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let yourWidth = collectionView.bounds.width
        return CGSize(width: yourWidth - 5, height: 230)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "idEventDetailsVC") as! EventDetailsVC
        if isUpcoming {
            vc.eventModeL = eventList[indexPath.row]
        } else {
            vc.eventModeL = eventComplitedList[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MMMM-dd"
        return  dateFormatter.string(from: date!)
        
    }

}
   
    



