//
//  MastHeadCrousalView.swift
//  Muvizz
//
//  Created by tilak raj verma on 08/12/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import UIKit


open class MastHeadCrousalCell : UITableViewCell, iCarouselDelegate, iCarouselDataSource {
    
    @IBOutlet weak var craousal: iCarousel?
    var items: [Int] = []
    
    class var identifier: String { return String.className(self) }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    open override func awakeFromNib() {
        
        setup()
    }
    
    open func setup() {
        
        self.craousal?.type = .linear
        self.craousal?.isPagingEnabled = true
    }
    
    open class func height() -> CGFloat {
        return 211
    }
    
    open func setData(_ data: [Int]) {
        
        self.backgroundColor = UIColor(hex: "FFFFFF")
    
        for  item in data {
    
            self.items.append(item)
        }
        self.craousal? .reloadData()
        
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.4
        } else {
            self.alpha = 1.0
        }
    }
    
    // ignore the default handling
    override open func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    public func numberOfItems(in carousel: iCarousel) -> Int {
        return items.count
    }
    
    public func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        var itemView: CustomContaintView1
        if let view = view as? CustomContaintView1 {
            itemView = view
            
        } else {
            
            let arrNibs = Bundle.main.loadNibNamed("CustomContaintView", owner: self, options: nil)
            itemView = arrNibs?[0] as! CustomContaintView1
            itemView.frame = CGRect.init(x:5, y: 0, width: carousel.bounds.size.width-10, height: 200)
        }
        
        itemView.lblCount.text = "Card \(items[index])"
        itemView.lblCount.textColor = UIColor.black
        return itemView
    }
    
    public func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
}
