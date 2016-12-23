//
//  DataManager.swift
//  Muvizz
//
//  Created by tilak raj verma on 22/12/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import Foundation

public class DataManager {
    
     static let sharedInstance = DataManager()
    func doSomthing()  {
        
        print("Hello check singlton")
    }
    
    func getBannerData(onsuccess:@escaping (AnyObject?,Bool)-> Void) -> Void {

        let urlSring = "\(Constants.API_BASE_URL)banners"
        getDatafromUrl(urlString: urlSring) { (data, response, error) in
            
            if data != nil {
                do {
                    
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    let theBanner_root = BannerMain.init(jsonObject as AnyObject)
                    onsuccess(theBanner_root as AnyObject?,true)
                }
                catch {
                    
                    onsuccess(nil,false)
                }
            }
            else {
                
                onsuccess(nil,false)
            }
        }
    }
    
    func getOtherDataFromMenthod(_ methodParam:String,sectionName:String,onsuccess:@escaping (AnyObject?,Bool)-> Void) -> Void
    {
        let urlSring = "\(Constants.API_BASE_URL)movies?categories%5B%5D=\(methodParam)"
        
        getDatafromUrl(urlString: urlSring) { (data, response, error) in
            
            if data != nil {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    let tempObject = jsonObject as? [String: AnyObject]
                    let theBanner_root = OtherDataSubRoot.init((tempObject?["data"] as? [AnyObject])!,headrTitle:sectionName)
                    onsuccess(theBanner_root as AnyObject?,true)
                    
                }
                catch {
                    
                    onsuccess(nil,false)
                }
            }
            else {
                
                onsuccess(nil,false)
            }
            
        }
    }
    
    
    func getMoviesDataFromMenthod(_ methodParam:String,sectionName:String,onsuccess:@escaping (AnyObject?,Bool)-> Void) -> Void
    {
        let urlSring = "\(Constants.API_BASE_URL)movies?\(methodParam)"
        
        getDatafromUrl(urlString: urlSring) { (data, response, error) in
            
            if data != nil {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    let tempObject = jsonObject as? [String: AnyObject]
                    let theBanner_root = OtherDataSubRoot.init((tempObject?["data"] as? [AnyObject])!,headrTitle: sectionName)
                    onsuccess(theBanner_root as AnyObject?,true)
                }
                catch {
                    
                    onsuccess(nil,false)
                }
            }
            else {
                
                onsuccess(nil,false)
            }
            
        }
    }
    
    
    func getBundleDataFromMenthod(_ methodParam:String,sectionName:String,onsuccess:@escaping (AnyObject?,Bool)-> Void) -> Void
    {
        let urlSring = "\(Constants.API_BASE_URL)products/bundles\(methodParam)"
        
        getDatafromUrl(urlString: urlSring) { (data, response, error) in
            
            if data != nil {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    let tempObject = jsonObject as? [AnyObject]
                    let theBanner_root = OtherDataSubRoot.init(tempObject!,headrTitle: sectionName)
                    onsuccess(theBanner_root as AnyObject?,true)
                }
                catch {
                    
                    onsuccess(nil,false)
                }
            }
            else {
                
                onsuccess(nil,false)
            }
            
        }
    }
    
    
    
    func getDatafromUrl(urlString:String,oncompletion:@escaping (Data?, URLResponse?, Error?)->Void) -> Void
    {
        let url = URL(string: urlString)!
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode / 100 != 2
                {
                    return
                }
                oncompletion(data,response,error)
            }
        }
        task.resume()
    }
}
