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

class DataTableViewCell : BaseTableViewCell, iCarouselDataSource, iCarouselDelegate, TilesScrollerViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var lblSectionTitle: UILabel!
    //@IBOutlet weak var craousal: iCarousel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var craousal: TilesScrollerView!
    var items: [Int] = []
    var cellSectonTitle:String = ""
    
    override func awakeFromNib() {
        
        //self.craousal.type = .linear
        //self.craousal.isPagingEnabled = false
        //self.craousal.contentOffset=CGSize.init(width: 0, height: 0)
        btnViewAll.layer.cornerRadius = 5.0
        btnViewAll.layer.borderWidth = 1.0
        btnViewAll.layer.borderColor = UIColor.white.cgColor
        lblSectionTitle.text = "Section Title"
        
    }
    
    func setCollectionViewDataSourceDelegate <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>> (dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
 
    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        
        set {
            collectionView.contentOffset.x = newValue
        }
    }
    
    override class func height() -> CGFloat {
        return 215
    }
    
    public func setCellData(_ data: [Int] , sectionTitle:String) {
        
        self.items = data
        self.lblSectionTitle.text = sectionTitle
    }
    
    func noOfItemsInTilesScrollerView(tilesScrollerView: TilesScrollerView) -> Int {
        
        return self.items.count
    }
    
    func viewInTilesScrollerViewAtIndex(tilesScrollerView: TilesScrollerView, reusing view: UIView?, index: Int) -> UIView {
        
        if  view == nil {
            
            return UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width:100, height: 100))
        }
        
        return view!;
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
