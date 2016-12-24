//
//  FinalDetailViewController.swift
//  Muvizz
//
//  Created by tilak raj verma on 17/12/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import Foundation


class FinalDetailViewController: UIViewController {
    
    var datamainObects: DataMainObject!
    var detailsDataModels: DetailsDataModels!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parsing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.removeNavigationBarItem()
        //self.setNavigationBarItem()
    }
    
    func getDetailsData(datamainObects: DataMainObject!)  {
        self.datamainObects = datamainObects
        print("The Api Link:\(datamainObects.rel!)")
        
    }
    func parsing()  {
        
        print("The Api Link:\(self.datamainObects.rel!)")
        DataManager.sharedInstance.getDatafromUrl(urlString:self.datamainObects.rel!)
        { (data, response, error) in
            if error == nil {
                do {
                   let jsonresponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    
                    if jsonresponse is [String : AnyObject] {
                        
                      self.detailsDataModels = DetailsDataModels.init((jsonresponse as? [String : AnyObject])!)
                        
                        print("the details:\(self.detailsDataModels.cast.joined(separator: ","))")
                    }
                }
                catch {
                    
                }
                
            }
        }
    }
    
    
}
