//
//  Constants.swift
//  Muvizz
//
//  Created by tilak raj verma on 23/12/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import Foundation


struct Constants {
    
   static let  API_BASE_URL = "http://api.muvizz.com/api/v1/"
   static let  BASEURL = "http://api.muvizz.com/"
}

enum SectionType {
    case FREEE,SUBSCRIPTION,PAY_PER_VIEW,BUNDLE,RECENTLY_ADDED
}

public func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60)
}

extension String {
    func deleteHTMLTag(tag:String) -> String {
          return  self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
     
    }
    
    func deleteHTMLTags(tags:[String]) -> String {
        var mutableString = self
        for tag in tags {
            mutableString = mutableString.deleteHTMLTag(tag: tag)
        }
        return mutableString
    }
}
