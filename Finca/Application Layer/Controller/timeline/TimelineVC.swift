//
//  TimelineVC.swift
//  Finca
//
//  Created by harsh panchal on 19/08/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

class TimelineVC: BaseVC {

    @IBOutlet weak var tbvTimeline: UITableView!
    
    
    var feedArray = [FeedModel]()
    let itemCell_image  = "TimeLineImageCell"
    let itemCell_text = "TimeLineTextCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib1 = UINib(nibName: itemCell_image, bundle: nil)
        tbvTimeline.register(nib1, forCellReuseIdentifier: itemCell_image)
        doLoadFeed()
        let nib2 = UINib(nibName: itemCell_text, bundle: nil)
        tbvTimeline.register(nib2, forCellReuseIdentifier: itemCell_text)
        tbvTimeline.estimatedRowHeight = 300
        tbvTimeline.rowHeight = UITableView.automaticDimension
        tbvTimeline.delegate = self
        tbvTimeline.dataSource = self
        
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didClickComment(_ sender:UIButton){
        if sender.tag == 20{
            
        }else if sender.tag == 21{
            
        }
    }
    
    @objc func didClickLike(_ sender : UIButton ){
        if sender.tag == 10{
            
        }else if sender.tag == 11{
            
        }
    }
    
    func doLoadFeed() {
        showProgress()
        
        let params = ["key":ServiceNameConstants.API_KEY,
                      "getFeed":"getFeed",
                      "society_id":doGetLocalDataUser().society_id!,
                      "user_id":doGetLocalDataUser().user_id!,
                      "unit_id":doGetLocalDataUser().unit_id!,
                      "user_name":doGetLocalDataUser().user_full_name!,
                      "block_name":doGetLocalDataUser().block_name!]
        
        print("param" , params)
        
        let request = AlamofireSingleTon.sharedInstance
        
        request.requestPost(serviceName: ServiceNameConstants.newsFeedController, parameters: params) { (json, error) in
            self.hideProgress()
            
            if json != nil {
                
                do {
                    let response = try JSONDecoder().decode(FeedResponse.self, from:json!)
                    if response.status == "200" {
                        self.feedArray.append(contentsOf: response.feed)
                        self.tbvTimeline.reloadData()
                        
                    }else {
                        
                    }
                    print(json as Any)
                } catch {
                    print("parse error")
                }
            }
        }
    }
}
extension TimelineVC : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 0 for image type cell
        // 1 for text type cell
        let cell = UITableViewCell()
        if feedArray[indexPath.row].feedType == "1"{
            let imageCell = tbvTimeline.dequeueReusableCell(withIdentifier: itemCell_image, for: indexPath)as! TimeLineImageCell
            let imageArray = feedArray[indexPath.row].feedImg
            imageCell.imgArray = imageArray!
            print("image arr count == \(imageArray!.count)")
            print("image arr count == \(imageArray!.count)")
            imageCell.pagerControl.numberOfPages = feedArray[indexPath.row].feedImg.count
            imageCell.lblUserName.text = feedArray[indexPath.row].userName
            Utils.setImageFromUrl(imageView: imageCell.imgUserProfile, urlString: feedArray[indexPath.row].userProfilePic)
            imageCell.lblflatName.text =  feedArray[indexPath.row].blockName
            imageCell.ImgPager.reloadData()
//            \(feedArray[indexPath.row].like.count)
           
            imageCell.lblPostDescription.text = feedArray[indexPath.row].feedMsg
           
            imageCell.lblPostDateAndTime.text = feedArray[indexPath.row].modifyDate
            imageCell.selectionStyle = .none
            if feedArray[indexPath.row].comment != nil{
                imageCell.lblCommentCount.text = "\(feedArray[indexPath.row].comment.count) comments"
            }else{
                 imageCell.lblCommentCount.text = "0 comments"
            }
            
            if feedArray[indexPath.row].like != nil{
                  imageCell.lblPostLIkeCount.text = "\(feedArray[indexPath.row].like.count) likes"
            }else{
                imageCell.lblPostLIkeCount.text = "0 likes"
               
            }
            imageCell.btnLike.tag = 10
            imageCell.btnLike.addTarget(self, action: #selector(didClickLike(_:)), for: .touchUpInside)
            imageCell.btnComment.tag = 20
            imageCell.btnLike.addTarget(self, action: #selector(didClickComment(_:)), for: .touchUpInside)
            return imageCell
            
        }else if feedArray[indexPath.row].feedType == "0"{
            let textCell = tbvTimeline.dequeueReusableCell(withIdentifier: itemCell_text, for: indexPath)as! TimeLineTextCell
            textCell.lblPostMessafe.text = feedArray[indexPath.row].feedMsg
            
            if feedArray[indexPath.row].comment != nil{
                textCell.lblCommentCount.text = "\(feedArray[indexPath.row].comment.count) comments"
            }else{
                textCell.lblCommentCount.text = "0 comments"
            }
            Utils.setImageFromUrl(imageView: textCell.imgUserProfile, urlString: feedArray[indexPath.row].userProfilePic)
            textCell.lblPostDate.text = feedArray[indexPath.row].modifyDate
            
            if feedArray[indexPath.row].like != nil{
            textCell.lblLikeCount.text = "\(feedArray[indexPath.row].like.count) likes"
            }else{
                textCell.lblLikeCount.text = "0 likes"
            }
            textCell.lblBlockName.text = feedArray[indexPath.row].blockName
            textCell.btnLike.tag = 11
            textCell.btnLike.addTarget(self, action: #selector(didClickLike(_:)), for: .touchUpInside)
            textCell.btnComment.tag = 21
            textCell.btnComment.addTarget(self, action: #selector(didClickComment(_:)), for: .touchUpInside)
            textCell.selectionStyle = .none
            
            return textCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
