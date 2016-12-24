//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

class MainViewController: UIViewController,DataTableViewCellDelegate, MastHeadCrousalCellDelegate {

    @IBOutlet weak var loaderActivity: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
     var items: [OtherDataSubRoot] = []
     var storedOffsets = [Int: CGFloat]()
    weak var delegate: LeftMenuProtocol?
    var detailsViewController: UIViewController!
    
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnMenue: UIButton!
    var  bannerdata: BannerMain?
    var arrContents = [OtherDataSubRoot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  menuImage:UIImage = (btnMenue.imageView?.image)!
            btnMenue .setImage(menuImage.maskWithColor(color: UIColor.white), for: UIControlState.normal)
        
         self.getdataAndReload()
    }
    
    func  getdataAndReload() {
        
        self.loaderActivity.startAnimating()
            DataManager.sharedInstance.getBannerData { (data , isSuccess) in
                
                if isSuccess == true {
                    
                    DispatchQueue.main.async {
                        
                        self.bannerdata = data as? BannerMain
                        //self.tableView .reloadData()
                    }
                    
                }
                
                self.getFree()
            }
        
    }
    
    func getRecentlyAdded()  {
        
        DataManager.sharedInstance.getMoviesDataFromMenthod("",sectionName: SectionType.RECENTLY_ADDED) { (data, isSuccess) in
            
            if isSuccess == true {
                
                DispatchQueue.main.async {
                    
                    self.arrContents.append((data as? OtherDataSubRoot)!)
                    self.tableView .reloadData()
                    self.loaderActivity.stopAnimating()
                }
                
            } else {
                
                DispatchQueue.main.async {
                    self.tableView .reloadData()
                    self.loaderActivity.stopAnimating()
                }
                
                
            }
            
            
        }
    }
    
    func getFree()  {
        
        DataManager.sharedInstance.getOtherDataFromMenthod("Free",sectionName: SectionType.FREEE) { (data, isSuccess) in
            
            if isSuccess == true {
                
                DispatchQueue.main.async {
                    
                    self.arrContents.append((data as? OtherDataSubRoot)!)
                    //self.tableView .reloadData()
                    
                }
                
            }
            
            self.payperview()
        }
    }
    
    func payperview()  {
        
        DataManager.sharedInstance.getOtherDataFromMenthod("pay%20per%20view",sectionName: SectionType.PAY_PER_VIEW) { (data, isSuccess) in
            
            if isSuccess == true {
                
                DispatchQueue.main.async {
                    
                    self.arrContents.append((data as? OtherDataSubRoot)!)
                    //self.tableView .reloadData()
                }
                
            }
            
            self.subscribed()
        }
    }
    func subscribed()  {
        
        DataManager.sharedInstance.getOtherDataFromMenthod("subscription",sectionName: SectionType.SUBSCRIPTION) { (data, isSuccess) in
            
            if isSuccess == true {
                
                DispatchQueue.main.async {
                    
                    self.arrContents.append((data as? OtherDataSubRoot)!)
                    //self.tableView .reloadData()
                    
                }
                
            }
            
            self.bundle()
        }
    }
    func bundle()  {
        
        DataManager.sharedInstance.getBundleDataFromMenthod("",sectionName: SectionType.BUNDLE) { (data, isSuccess) in
            
            if isSuccess == true {
                
                DispatchQueue.main.async {
                    
                    self.arrContents.append((data as? OtherDataSubRoot)!)
                    //self.tableView .reloadData()
                }
                
            }
            
            self.getRecentlyAdded()
        }
    }
    
    
    @IBAction func btnMenuClick(_ sender: AnyObject) {
       
         self.openLeft()
    }
    @IBAction func btnSearchClick(_ sender: AnyObject) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
       
        //self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            
            if self.bannerdata == nil {
                return 0
            }
            if (self.bannerdata?.arrBannerrs.count)! > 0  {
                 return MastHeadCrousalCell.height()
            }
            return 0
        }
        return DataTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "SubContentsViewController", bundle: nil)
        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "SubContentsViewController") as! SubContentsViewController
        self.navigationController?.pushViewController(subContentsVC, animated: true)
    }
}

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return self.arrContents.count+1
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MastHeadCrousalCell.identifier) as! MastHeadCrousalCell
            cell.delegate = self
            
            if bannerdata != nil {
                
               cell.setData((bannerdata?.arrBannerrs)!)
                
            }
            
            return cell;
            
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.identifier) as! DataTableViewCell
            cell.delegate = self
            let dataAtIndex = self.arrContents[indexPath.row-1]
            
            cell.setCellData(dataAtIndex,sectionTitle: dataAtIndex.sectionTitle!)
            cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row-1)
            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell;
        }
    }
    
    //MARK:VIEW ALL CLICK HERE
    func didClickOnViewAll(index: Int) {
        
       
        let dataAtIndex = self.arrContents[index]
         print("the View All Click\(dataAtIndex.sectionTitle)")

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        self.detailsViewController = UINavigationController(rootViewController: swiftViewController)
        self.slideMenuController()?.changeMainViewController(self.detailsViewController, close: true)
    }
    
    func didSelectedItemAtIndex(index: Int, data: BannerSubRoot) {
        
        print("the selected banner at index:\(data.type!)")
        
        if data.type!.lowercased() == "external" {
            
             print("the selected banner at index:\(data.dataobj as! String)")
            UIApplication.shared.openURL(URL.init(string:data.dataobj as! String)!)
            
        } else if data.type!.lowercased() == "movie" {
            
            let mainObject = data.dataobj as? DataMainObject
            print("the obect:\(mainObject?.length)")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let swiftViewController = storyboard.instantiateViewController(withIdentifier: "FinalDetailViewController") as! FinalDetailViewController
            swiftViewController.getDetailsData(datamainObects:mainObject)
            
            self.navigationController?.pushViewController(swiftViewController, animated: true)
        }
    }
}


// func tableView(tableView: UITableView,
//                        didEndDisplayingCell cell: UITableViewCell,
//                        forRowAtIndexPath indexPath: NSIndexPath) {
//    
//    guard let tableViewCell = cell as? DataTableViewCell else { return }
//    
//    storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
//}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return self.arrContents[collectionView.tag].arrDataSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollection",
                                                      for: indexPath)
        
        let theImageView = cell .viewWithTag(1001) as! UIImageView
        
        let dataAtIndex =  self.arrContents[collectionView.tag].arrDataSet[indexPath.row]
        
        if (dataAtIndex.thumbnail != nil)  {
            
            let baseImagePath = "\(Constants.BASEURL)\(dataAtIndex.thumbnail.path)"
            
            theImageView.load.request(with: URL.init(string: baseImagePath)!)
            
        }
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
          let dataAtIndex =  self.arrContents[collectionView.tag].arrDataSet[indexPath.row]
        print("\(dataAtIndex.name!)")
    }
}

extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
