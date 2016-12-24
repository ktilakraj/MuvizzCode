//
//  FinalDetailViewController.swift
//  Muvizz
//
//  Created by tilak raj verma on 17/12/16.
//  Copyright © 2016 Yuji Hato. All rights reserved.
//

import Foundation


class FinalDetailViewController: UIViewController {
    
    @IBOutlet weak var tblViewDetails: UITableView!
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
        self.tblViewDetails.estimatedRowHeight = 80
        self.tblViewDetails.rowHeight = UITableViewAutomaticDimension
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
                        
                        DispatchQueue.main.async {
                            
                            self.tblViewDetails.reloadData()
                        }
                        
                      
                    }
                }
                catch {
                    
                }
                
            }
        }
    }
}

extension FinalDetailViewController:UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 6
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if self.detailsDataModels == nil {
            
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            
            let cell = tblViewDetails .dequeueReusableCell(withIdentifier: "playcell", for: indexPath)
            
            let imageViewBanner = cell.contentView.viewWithTag(1001) as? UIImageView
            let posterUrl  = self.detailsDataModels.poster.path
            
            let finalUlr = "\(Constants.BASEURL)\(posterUrl)"
            
           _ = imageViewBanner?.load.request(with: URL.init(string: finalUlr)!)
            return cell;
        }
        if indexPath.row == 1 {
            
            let cell = tblViewDetails .dequeueReusableCell(withIdentifier: "celltitleanddurationdetails", for: indexPath)
            let lblTitle  = cell.contentView.viewWithTag(1001) as? UILabel
            let viewFlaotingrating  = cell.contentView.viewWithTag(1002) as? FloatRatingView
            let viewtemp  = cell.contentView.viewWithTag(1003)
            let lblgenersandduration  = viewtemp?.viewWithTag(1004) as? UILabel
            lblTitle?.text = ""
            if self.detailsDataModels?.name != nil  {
               lblTitle?.text = self.detailsDataModels.name
            }
            
            var arrCOmb = [String]()
            if self.detailsDataModels?.genersplainText != nil {
                arrCOmb.append((self.detailsDataModels?.genersplainText.joined(separator: ","))!) 
            }
           
            arrCOmb.append((self.detailsDataModels?.durationInHM!)!)
            lblgenersandduration?.text = arrCOmb.joined(separator: " | ")
           
            viewFlaotingrating?.emptyImage = UIImage(named: "StarEmpty")?.maskWithColor(color: UIColor.white)
            viewFlaotingrating?.fullImage = UIImage(named: "StarFull")?.maskWithColor(color: UIColor.white)
            viewFlaotingrating?.maxRating = 5
            viewFlaotingrating?.minRating = 1
            viewFlaotingrating?.editable = false
            viewFlaotingrating?.halfRatings = false
            viewFlaotingrating?.floatRatings = true
            viewFlaotingrating?.rating = 0.0
            if  self.detailsDataModels.average_rating != nil {
                let number = NumberFormatter().number(from: self.detailsDataModels.average_rating!)
                let numberFloatValue = number?.floatValue
                viewFlaotingrating?.rating = numberFloatValue!
            }
            
            return cell;
        }
        
        if indexPath.row == 2 {
        
            let cell = tblViewDetails .dequeueReusableCell(withIdentifier: "celldirector", for: indexPath)
            let lblTitleDirector  = cell.contentView.viewWithTag(1001) as? UILabel
            let lblTitleStarring  = cell.contentView.viewWithTag(1002) as? UILabel
            
            let dirct = self.detailsDataModels.directors.joined(separator: ",")
           let cast =  self.detailsDataModels.cast.joined(separator: ",")
            
            lblTitleDirector?.text = "Director: \(dirct)"
            lblTitleStarring?.text = "Starring: \(cast)"
            
            return cell
        }
        if indexPath.row == 3 {
            
            let cell = tblViewDetails .dequeueReusableCell(withIdentifier: "celldetials", for: indexPath)
            let lblTitleDirector  = cell.contentView.viewWithTag(1001) as? UILabel
           
            let dirct = self.detailsDataModels.synopsis!
            lblTitleDirector?.text = "Director: \(dirct.deleteHTMLTag(tag: ""))"
          
            
            return cell
        }
        
        if indexPath.row == 4 {
            
             let cell = tblViewDetails .dequeueReusableCell(withIdentifier: "cellTrailer", for: indexPath)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension FinalDetailViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 250
        case 1:
            return 90
        case 2:
            return 91
        case 3:
            return UITableViewAutomaticDimension
        case 4:
            return 58
        default:
            return 0
        }
    }
}


