//
//  TilesScrollerView.swift
//  Muvizz
//
//  Created by tilak raj verma on 13/12/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import UIKit


@objc public protocol TilesScrollerViewDataSource {
    
     func noOfItemsInTilesScrollerView(tilesScrollerView :TilesScrollerView) -> Int
    func viewInTilesScrollerViewAtIndex(tilesScrollerView :TilesScrollerView,reusing view:UIView?,index:Int) -> UIView
}

public class  TilesScrollerView: UIView {
    
    var contentView:UIView?
    var dataSource:TilesScrollerViewDataSource?
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    func setup() -> Void {
        
        contentView = UIView.init(frame: self.bounds)
        contentView?.backgroundColor = UIColor.cyan
        self.addSubview(contentView!)
    }
    
    func reloadTilesScrollerView() -> Void {
        
        let itemCount = dataSource?.noOfItemsInTilesScrollerView(tilesScrollerView: self)
        print("the item count:\(itemCount)")
        var Sum = 0
        var xPos:CGFloat = 5
        while Sum < itemCount! {
            
            let tags = Sum+100
            let viewInTilesView = (self.contentView?.viewWithTag(tags))
            
            var  itemView = dataSource?.viewInTilesScrollerViewAtIndex(tilesScrollerView: self, reusing: viewInTilesView , index: Sum)
            print("the item View count:\(Sum)")
            
            if self.contentView?.viewWithTag(tags) == nil {
                itemView?.tag = tags
                self.contentView?.addSubview(itemView!)
            }
            itemView = self.contentView?.viewWithTag(tags)
            var actualBounds = itemView?.bounds
            let itemWidth:CGFloat = (actualBounds!.size.width)
            if Sum != 0 {
               xPos = xPos+itemWidth
            }
            actualBounds?.origin.x = xPos
            itemView?.bounds = actualBounds!
            
            if tag%2 == 0 {
                
                itemView?.backgroundColor = UIColor.red
            } else {
                
                itemView?.backgroundColor = UIColor.yellow
            }
            Sum += 1
            
        }
        
        self.reloadInputViews()
    }
}
