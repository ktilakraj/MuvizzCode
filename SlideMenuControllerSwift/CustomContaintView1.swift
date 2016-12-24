//
//  CustomContaintView1.swift
//  Muvizz
//
//  Created by Tilak on 12/7/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import UIKit



class CustomContaintView1: UIView {
    
    @IBOutlet weak var imageViewbanner: UIImageView!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblduration: UILabel!
    var  bannerRoot:BannerSubRoot!
    @IBOutlet weak var lblcc: UILabel!
    
    @IBOutlet weak var viewrating: FloatRatingView!
    
    @IBOutlet weak var lblhq: UILabel!
    override func awakeFromNib() {
        
        self.viewrating.emptyImage = UIImage(named: "StarEmpty")?.maskWithColor(color: UIColor.white)
        self.viewrating.fullImage = UIImage(named: "StarFull")?.maskWithColor(color:UIColor.white)
        self.viewrating.maxRating = 5
        self.viewrating.minRating = 1
        self.viewrating.editable = false
        self.viewrating.halfRatings = false
        self.viewrating.floatRatings = true
        self.lblcc.layer.cornerRadius = 2.5
        self.lblcc.clipsToBounds = true
        self.lblhq.layer.cornerRadius = 2.5
        self.lblhq.clipsToBounds = true
        self.viewrating.rating = 0.0
    }
    func setbannerData(_ data:BannerSubRoot!) -> Void {
        
        self.bannerRoot = data
        self.lblCount.text = "\(data.type!)"
        self.lblCount.textColor = UIColor.black
        let imageUrl:String = "\(Constants.BASEURL)\(data.imageNode!.path)"
        self.imageViewbanner.load.request(with: imageUrl)
        self.viewDetails.isHidden = true
        self.viewrating.rating = 0.0
        if data.type!.lowercased() == "external" {
            
        } else if data.type!.lowercased() == "movie" {
            
            let dataObect  = data.dataobj as! DataMainObject
            self.lblduration.text = "0h 0m"
            
            if  dataObect.length != nil {
                let number = NumberFormatter().number(from: dataObect.length!)
                let (h,m) = secondsToHoursMinutesSeconds(seconds: (number?.intValue)!)
                let strcomb = "\(h)h \(m)m"
                self.lblduration.text = strcomb
                
            }
            
            if  dataObect.average_rating != nil {
                let number = NumberFormatter().number(from: dataObect.average_rating!)
                let numberFloatValue = number?.floatValue
                self.viewrating.rating = numberFloatValue!
            } else {
                self.viewrating.rating = 0.0
            }
             self.viewDetails.isHidden = false
            
        }
        
    }
    
}
