//
//  DataTableViewCell.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/8/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

struct DataTableViewCellData {
    
    init(imageUrl: String, text: String) {
        self.imageUrl = imageUrl
        self.text = text
    }
    var imageUrl: String
    var text: String
}

class DataTableViewCell : BaseTableViewCell, iCarouselDataSource, iCarouselDelegate {

    
    @IBOutlet weak var craousal: iCarousel!
    var items: [Int] = []
    
    override func awakeFromNib() {
        
        self.craousal.type = .linear
        self.craousal.isPagingEnabled = false
        self.craousal.contentOffset=CGSize.init(width: 0, height: 0)
    }
 
    
    override class func height() -> CGFloat {
        return 100
    }
    
    public func setCellData(_ data: [Int]) {
        
        self.items = data;
        self.craousal.reloadData()
        self.craousal.scrollToItem(at: 2, animated: true)
        
        
    }
    
    public func numberOfItems(in carousel: iCarousel) -> Int {
        return self.items.count
    }
    
    public func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var itemView: CustomContaintView1
        if let view = view as? CustomContaintView1 {
            itemView = view
            
        } else {
            
            let arrNibs = Bundle.main.loadNibNamed("CustomContaintView", owner: self, options: nil)
            itemView = arrNibs?[0] as! CustomContaintView1
            itemView.frame = CGRect.init(x:5, y: 0, width: 80, height: 100)
        }
        
        itemView.lblCount.text = "\(self.items[index])"
        return itemView
    }
    
    public func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
}
