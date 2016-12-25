//
//  SwiftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//



import UIKit

class BundleDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionviewDetais: UICollectionView!
    @IBOutlet weak var lblDetails: UILabel!
    var tempSubmenuDetals : DataMainObject!
    var arrLanguageDetas = [String]()
    var  arrAllCards = [DataMainObject]()
    var  selectedLanguage:String = "All"
    
    
    @IBOutlet weak var btnPayNow: UIButton!
    var totalPage:Int = 0
    var currentPage:Int = 1
    
    @IBOutlet weak var lblOfferPrice: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var chooseArticleButton: UIButton!
    let chooseArticleDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chooseArticleButton.isHidden = true
        setupData()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.setNavigationBarItem()
        
        self.arrAllCards = (self.tempSubmenuDetals?.arrMoviedataObjects)!
        self.collectionviewDetais.reloadData()
        self.lblPrice.text = "Total Price: ₹\(self.tempSubmenuDetals.original_price)"
        self.lblOfferPrice.text = "Offered Price: ₹\(self.tempSubmenuDetals.amount)"
       
    }
    
    func setUpdataObject(dataObject:DataMainObject)  {
        
        self.tempSubmenuDetals = dataObject
        
    }
    func setupData() -> Void {
        
        if self.lblDetails != nil {
            
            self.lblDetails.text = tempSubmenuDetals?.name
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 3
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellDetails", for: indexPath)
        
        
        let imageView =  cell.viewWithTag(1001) as? UIImageView
        let  theArrayIndex:Int =  indexPath.section*3+indexPath.row
        
        let isIndexValid = self.arrAllCards.indices.contains(theArrayIndex)
      
        imageView?.isHidden = false
        if isIndexValid == false {
            imageView?.isHidden = true
            return cell
        }
        let cardAtindex = self.arrAllCards[theArrayIndex]
        
        print("indxpath.row : \(indexPath.row) with section:\(indexPath.section) and arrayIndex:\(theArrayIndex)")
        
        let theImageString = "\(Constants.BASEURL)\(cardAtindex.thumbnail.path)"
        _ = imageView?.load.request(with: URL.init(string: theImageString)!)

        return cell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        if  self.arrAllCards .count > 0 {
            
            let index = self.arrAllCards.count % 3
            let rowCount = self.arrAllCards.count / 3
            if  index == 0 {
                
                return rowCount
                
            } else if index > 0 {
                return rowCount+1
            }
        }
        else  {
            
            return 0
        }
       
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let heightCal = (collectionView.frame.size.height/collectionView.frame.size.width)*(collectionView.frame.size.width/3.2)
        return CGSize(width: collectionView.frame.size.width/3.2, height: heightCal+20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let  theArrayIndex:Int =  indexPath.section*3+indexPath.row
        let isIndexValid = self.arrAllCards.indices.contains(theArrayIndex)
        if isIndexValid == false {
            
            return
        }
        
        let cardAtindex = self.arrAllCards[theArrayIndex]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "FinalDetailViewController") as! FinalDetailViewController
        swiftViewController.getDetailsData(datamainObects:cardAtindex)
        self.navigationController?.pushViewController(swiftViewController, animated: true)
    }
    

    @IBAction func btnPayNowClick(_ sender: Any) {
        
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        

       let  currentOffset = scrollView.contentOffset.y
       let maximumOffset  = scrollView.contentSize.height - scrollView.frame.size.height
        if (maximumOffset - currentOffset) <= 10 {
            
            if self.currentPage >= self.totalPage {
                
                return
            }
            
            if self.currentPage < self.totalPage {
                self.currentPage += self.currentPage
                //self.getPaginationdata()
            }
            
        }
        
    }
    
}
