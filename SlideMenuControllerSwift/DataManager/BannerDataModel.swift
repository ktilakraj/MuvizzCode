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
    var arrMoviedataObjects = [DataMainObject]()
    
    var original_price:String = ""
    var amount:String = ""
    
    init(_ jsonObjects:[String:AnyObject]) {
        
        self.id = jsonObjects["id"] as? Int
        self.name = jsonObjects["name"] as? String
        self.views = jsonObjects["views"] as? String
        self.average_rating = jsonObjects["average_rating"] as? String
        self.length = jsonObjects["length"] as? String
        self.synopsis = jsonObjects["synopsis"] as? String
        self.rel = jsonObjects["rel"] as? String
        
        if jsonObjects["original_price"] != nil {
             self.original_price = jsonObjects["original_price"] as! String
        }
        if jsonObjects["amount"] != nil {
            
            self.amount = jsonObjects["amount"] as! String
        }
    
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
                self.arrMoviedataObjects.append(DataMainObject.init(tempItem!))
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

public struct DetailsDataModels
{
    var id:Int?
    var name: String?
    var thumbnail: ImageNodeOrThumbnail!
    var poster: ImageNodeOrThumbnail!
    var views: String?
    var average_rating: String?
    var length: String?
    var products: [Product]? = []
    var synopsis: String?
    var rel:String?
    var hasAccess:Bool = false
    var tags = [AnyObject]()
    var countrycode = [AnyObject]()
    var crew = [AnyObject]()
    var producers = [String]()
    var directors = [String]()
    var cast = [String]()
    var geners = [DefaultDataModel]()
    var genersplainText = [String]()
    var categories = [DefaultDataModel]()
    var languages = [DefaultDataModel]()
    var durationInHM: String?
    

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
        
        let thegeners = jsonObjects["genres"] as? [AnyObject]
        if  thegeners != nil {
            for product in thegeners!  {
                let tempProduct = product as! [String : AnyObject]
                self.geners.append(DefaultDataModel.init(tempProduct))
                self.genersplainText.append((tempProduct["name"] as? String)!)
            }
        }
        
        let thecategories = jsonObjects["categories"] as? [AnyObject]
        if  thecategories != nil {
            for product in thecategories!  {
            let tempProduct = product as! [String : AnyObject]
            self.categories.append(DefaultDataModel.init(tempProduct))
            }
        }
        let thelanguages = jsonObjects["languages"] as? [AnyObject]
        if  thelanguages != nil {
            for product in thelanguages!  {
                let tempProduct = product as! [String : AnyObject]
                self.languages.append(DefaultDataModel.init(tempProduct))
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
        
        let tempposter = jsonObjects["poster"] as? [String : AnyObject]
        if tempposter != nil {
            self.poster = ImageNodeOrThumbnail.init(tempposter!)
        }
        
        let thetags = jsonObjects["tags"] as? [AnyObject]
        if  thetags != nil {
            self.tags = thetags!
        }
        let countrycodes = jsonObjects["countrycode"] as? [AnyObject]
        if  countrycodes != nil {
            self.countrycode = countrycodes!
        }
        
        let crews = jsonObjects["crew"] as? [AnyObject]
        if  crews != nil {
            self.crew = crews!
        }
        
        let casts = jsonObjects["cast"] as? [String]
        if  casts != nil {
            self.cast = casts!
        }
        
        let directorse = jsonObjects["directors"] as? [String]
        if  directorse != nil {
            self.directors = directorse!
        }
        let producers = jsonObjects["producers"] as? [String]
        if  producers != nil {
            self.producers = producers!
        }
        
        if  self.length != nil {
            let number = NumberFormatter().number(from: self.length!)
            let (h,m) = secondsToHoursMinutesSeconds(seconds: (number?.intValue)!)
            let strcomb = "\(h)h \(m)m"
            self.durationInHM = strcomb
        }
    }
}

public struct DefaultDataModel {
    var id:Int!
    var name:String!
    
    init(_ jsonObject:[String:AnyObject]) {
        
        self.id = jsonObject["id"] as? Int
        self.name = jsonObject["name"] as? String
        
    }
    
}




