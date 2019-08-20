//
//  TimeLineImageCell.swift
//  Finca
//
//  Created by harsh panchal on 19/08/19.
//  Copyright © 2019 anjali. All rights reserved.
//

import UIKit

class TimeLineImageCell: UITableViewCell {

    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblflatName: UILabel!
    @IBOutlet weak var lblPostDescription: UILabel!
    @IBOutlet weak var ImgPager: iCarousel!
    @IBOutlet weak var pagerControl: UIPageControl!
    @IBOutlet weak var lblPostLIkeCount: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var lblPostDateAndTime: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
    @IBOutlet weak var btnComment: UIButton!
    var imgArray = [FeedImgModel]()
    var index = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ImgPager.isPagingEnabled = true
        ImgPager.bounces = false
        ImgPager.delegate = self
        ImgPager.dataSource = self
        ImgPager.reloadData()
        pagerControl.numberOfPages = imgArray.count
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
}
extension TimeLineImageCell : iCarouselDelegate,iCarouselDataSource{
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        print(imgArray.count)
        return imgArray.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let viewCard = (Bundle.main.loadNibNamed("HomeSliderCell", owner: self, options: nil)![0] as? UIView)! as! HomeSliderCell
        
        
        Utils.setImageFromUrl(imageView: viewCard.ivImage, urlString: imgArray[index].feedImg)
        viewCard.frame = ImgPager.frame
        viewCard.viewMain.layer.cornerRadius = 10
//        viewCard.viewMain.backgroundColor = UIColor.gray
        viewCard.ivImage.layer.cornerRadius = 10
        viewCard.ivImage.contentMode = .scaleAspectFit
        viewCard.ivImage.clipsToBounds = true
//        viewCard.layer.masksToBounds = false
//        viewCard.layer.shadowColor = UIColor.black.cgColor
//        viewCard.layer.shadowOpacity = 0.5
//        viewCard.layer.shadowOffset = CGSize(width: -1, height: 1)
//        viewCard.layer.shadowRadius = 1
        return viewCard
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
//
//        if (option == .spacing) {
//            return value * 1.1
//        }
        return value
        
    }
    
    
    
    //scrolling started
    func carouselDidScroll(_ carousel: iCarousel) {
        index = carousel.currentItemIndex
        pagerControl.currentPage = carousel.currentItemIndex
        
        ////   print("index:\(index)")
    }
}
