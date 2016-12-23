//
//  BannerDataModel.swift
//  Muvizz
//
//  Created by tilak raj verma on 23/12/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import Foundation


public struct BannerMain {
    
    var arrBannerrs = [BannerSubRoot]()
   init(_ jsonObjects: AnyObject) {
        if jsonObjects is [AnyObject] {
            let objects = jsonObjects as? [AnyObject]
            for jsonObject in objects! {
                let  bannnerRoot = BannerSubRoot(jsonObject)
                self.arrBannerrs.append(bannnerRoot)
            }
        }
    }
}

public struct BannerSubRoot {
    
    let type:String?
    let dataobj:AnyObject?
    let imageNode:ImageNodeOrThumbnail?
    
    init(_ jsonObjects:AnyObject) {
        
        let jsonDict = jsonObjects as? [String : AnyObject]
        self.type = jsonDict?["type"] as? String
        if  jsonDict?["data"] is String  {
            self.dataobj = jsonDict?["data"]
        } else  {
            
            self.dataobj = DataMainObject((jsonDict?["data"])!) as AnyObject?
        }
        self.imageNode = ImageNodeOrThumbnail((jsonDict?["image"]) as! [String:AnyObject])
    }
   
}

public struct DataMainObject {
    
    var id:Int?
    var name: String?
    var thumbnail: ImageNodeOrThumbnail?
    var views: String?
    var average_rating: String?
    var length: String?
    var products: [Product]?
    var synopsis: String?
    var rel:String?
    
    init(_ jsonObjects:AnyObject) {
        
        
    }
}




public struct ImageNodeOrThumbnail {
    
    var name:String?
    var  path:String
    var  type:String?
    var  disc:String?
    var  size:Int?
    
    init(_ jsonObjects : [String: AnyObject]) {
        
        self.name = jsonObjects["name"] as? String
        self.path = jsonObjects["path"] as! String
        self.type = jsonObjects["type"] as? String
        self.disc = jsonObjects["disc"] as? String
        self.size = jsonObjects["size"] as? Int
        
    }
}

public struct Product {
    
    var id:String?
    var name: String?
    var duration:String?
    var duration_unit:String?
    var amount:String?
    var type:String?
    
    init(_ jsonObjects : AnyObject) {
        
        
    }
    
}


