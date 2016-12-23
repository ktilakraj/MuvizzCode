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
    @IBOutlet weak var lblCount: UILabel!
    var  bannerRoot:BannerSubRoot!
    func setbannerData(_ data:BannerSubRoot!) -> Void {
        
        self.bannerRoot = data
        self.lblCount.text = "\(data.type!)"
        self.lblCount.textColor = UIColor.black
        let imageUrl:String = "\(Constants.BASEURL)\(data.imageNode!.path)"
        self.imageViewbanner.load.request(with: imageUrl)
        
    }
}
