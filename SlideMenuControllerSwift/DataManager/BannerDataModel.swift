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
            
            self.dataobj = DataMainObject((jsonDict?["data"])! as! [String : AnyObject]) as AnyObject?
        }
        self.imageNode = ImageNodeOrThumbnail((jsonDict?["image"]) as! [String:AnyObject])
    }
}



public struct OtherDataSubRoot {
    
    var  arrDataSet = [DataMainObject]()
    var  sectionTitle:SectionType?
    
    
    init(_ jsonObject:[AnyObject] ,headrTitle:SectionType?) {
        self.sectionTitle = headrTitle
        for items in jsonObject {
            
            let tempItem = items as? [String:AnyObject]
            arrDataSet.append(DataMainObject.init(tempItem!))
        }
    }
}



public struct DataMainObject {
    
    var id:Int?
    var name: String?
    var thumbnail: ImageNodeOrThumbnail!
    var views: String?
    var average_rating: String?
    var length: String?
    var products: [Product]? = []
    var synopsis: String?
    var rel:String?
    var arrMoviedataObjects = [MoviewDataObject]()
    
    
    init(_ jsonObjects:[String:AnyObject]) {
        
        self.id = jsonObjects["id"] as? Int
        self.name = jsonObjects["name"] as? String
        self.views = jsonObjects["views"] as? String
        self.average_rating = jsonObjects["average_rating"] as? String
        self.length = jsonObjects["length"] as? String
        self.synopsis = jsonObjects["synopsis"] as? String
        self.rel = jsonObjects["rel"] as? String
       
        let theProducts = jsonObjects["products"] as? [AnyObject]
        if  theProducts != nil {
            
            for product in theProducts!  {
                let tempProduct = product as! [String : AnyObject]
                self.products?.append(Product.init(tempProduct))
            }
        }
      
        self.thumbnail = nil
        let thumbnails = jsonObjects["thumbnail"] as? [String : AnyObject]
        if thumbnails != nil {
            
            self.thumbnail = ImageNodeOrThumbnail.init(thumbnails!)
        }
        
        let tempimage = jsonObjects["image"] as? [String : AnyObject]
        if tempimage != nil {
            
            self.thumbnail = ImageNodeOrThumbnail.init(tempimage!)
        }
        
        let tempMovieObject = jsonObjects["movies"] as? [AnyObject]
        if tempMovieObject != nil {
            for movieItem in tempMovieObject! {
                let tempItem = movieItem as? [String:AnyObject]
                self.arrMoviedataObjects.append(MoviewDataObject.init(tempItem!))
            }
        }
        
    }
}

public struct MoviewDataObject {
    
    var id:Int?
    var name: String?
    var thumbnail: ImageNodeOrThumbnail!
    var views: String?
    var average_rating: String?
    var length: String?
    var products: [Product]? = []
    var synopsis: String?
    var rel:String?
    
    init(_ jsonObjects:[String:AnyObject]) {
        
        self.id = jsonObjects["id"] as? Int
        self.name = jsonObjects["name"] as? String
        self.views = jsonObjects["views"] as? String
        self.average_rating = jsonObjects["average_rating"] as? String
        self.length = jsonObjects["length"] as? String
        self.synopsis = jsonObjects["synopsis"] as? String
        self.rel = jsonObjects["rel"] as? String
        
        let theProducts = jsonObjects["products"] as? [AnyObject]
        if  theProducts != nil {
            
            for product in theProducts!  {
                let tempProduct = product as! [String : AnyObject]
                self.products?.append(Product.init(tempProduct))
            }
        }
        
        self.thumbnail = nil
        let thumbnails = jsonObjects["thumbnail"] as? [String : AnyObject]
        if thumbnails != nil {
            
            self.thumbnail = ImageNodeOrThumbnail.init(thumbnails!)
        }
        
        let tempimage = jsonObjects["image"] as? [String : AnyObject]
        if tempimage != nil {
            
            self.thumbnail = ImageNodeOrThumbnail.init(tempimage!)
        }
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
    
    var id:Int?
    var name: String?
    var duration:String?
    var duration_unit:String?
    var amount:String?
    var type:String?
    
    init(_ jsonObjects : [String:AnyObject]) {
        
        self.id = jsonObjects["id"] as? Int
        self.name = jsonObjects["name"] as? String
        self.duration = jsonObjects["duration"] as? String
        self.duration_unit = jsonObjects["duration_unit"] as? String
        self.amount = jsonObjects["amount"] as? String
        self.type = jsonObjects["type"] as? String
    }
    
}


