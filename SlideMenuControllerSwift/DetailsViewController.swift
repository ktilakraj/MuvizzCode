//
//  SwiftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//



import UIKit

class DetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionviewDetais: UICollectionView!
    @IBOutlet weak var lblDetails: UILabel!
    var tempSubmenuDetals : SubmenuDetails?
    var arrLanguageDetas = [String]()
    var datamainObjets = [DataMainObject]()
    var  arrAllCards = [DataMainObject]()
    var  selectedLanguage:String = "All"
    
    var totalPage:Int = 0
    var currentPage:Int = 1
    
    @IBOutlet weak var chooseArticleButton: UIButton!
    let chooseArticleDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupData()

        chooseArticleButton.isHidden = false
        lblDetails.isHidden = false
        
        if tempSubmenuDetals?.subMenuId != 1005
        {
            parsing()
            
        } else {
            
            chooseArticleButton.isHidden = true
            lblDetails.isHidden = true
            self.arrAllCards = self.datamainObjets
            self.collectionviewDetais.reloadData()
        }
        
       
    }
    
    
    
    func dropDwonInitialSetup() -> Void {
        
        setupDropDowns()
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .any }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
       
    }
    
    var submenuDetals: SubmenuDetails?{
       set(newX){
            tempSubmenuDetals = newX
        }
        get {
            return tempSubmenuDetals
        }
    }
    
    func setupData() -> Void {
        
        if self.lblDetails != nil {
            
            self.lblDetails.text = tempSubmenuDetals?.subMenuTitle
        }
        
    }
    
    func  parsing() {
        
        arrAllCards = [DataMainObject]()
        
        if DataManager.sharedInstance.arrLanguages.count == 0 {
            DataManager.sharedInstance.getLanguageData {
                
                self.meueManupulation()
            }
        } else
        {
            
            self.meueManupulation()
        }
        
        if tempSubmenuDetals != nil  {
           
            self.getPaginationdata()
        }
        
    }
    
    func getPaginationdata()  {
        
        self.getdataWithPageNumber(pageNum: currentPage, language: self.selectedLanguage, type:(tempSubmenuDetals?.subMenuTitle)!)
    }
    
    func getdataWithPageNumber(pageNum:Int,language:String,type:String) -> Void {
        
        //http://api.muvizz.com/api/v1/movies?categories%5B%5D=Short+Film&languages%5B%5D=Hindi&page=1
        
        var urlString = ""
        if (language.lowercased() == "all") {
            urlString = "\(Constants.API_BASE_URL)movies?categories%5B%5D=\(type.encodeUrl())&page=\(pageNum)"
        } else {
            urlString = "\(Constants.API_BASE_URL)movies?categories%5B%5D=\(type.encodeUrl())&languages%5B%5D=\(language)&page=\(pageNum)"
        }
        
        if tempSubmenuDetals?.subMenuId == 1004 {
            
            if (language.lowercased() == "all") {
                urlString = "\(Constants.API_BASE_URL)movies?page=\(pageNum)"
            } else {
                urlString = "\(Constants.API_BASE_URL)movies?languages%5B%5D=\(language)&page=\(pageNum)"
            }
        }
        
        DataManager.sharedInstance.getDatafromUrl(urlString: urlString) { (data, response, error) in
            if error == nil && data != nil {
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    let tempJaonResponse = jsonResponse as? [String:AnyObject]
                    
                    let pagination = tempJaonResponse?["pagination"] as? [String:AnyObject]
                    self.totalPage = (pagination?["total_pages"] as? Int)!
                    self.currentPage = (pagination?["current_page"] as? Int)!
                    let dataJson = tempJaonResponse?["data"] as? [AnyObject]
                    for item in dataJson! {
                        let tempdataJson = item as? [String:AnyObject]
                        self.arrAllCards.append(DataMainObject.init(tempdataJson!))
                    }
                    
                    DispatchQueue.main.async {
                        
                        self.collectionviewDetais.reloadData()
                        
                    }
                } catch {
                    
                }
                
                
            }
        }
    }
    
    func meueManupulation()  {
        
        arrLanguageDetas = [String]()
        for item in DataManager.sharedInstance.arrLanguages {
            arrLanguageDetas .append(item.name)
            
        }
        if self.arrLanguageDetas.contains("All") == false
        {
           arrLanguageDetas.insert("All", at: 0)
        }
        dropDwonInitialSetup()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 3
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellDetails", for: indexPath)
        
        
        let imageView =  cell.viewWithTag(1001) as? UIImageView
        let viewsub =  cell.viewWithTag(1002)
        let lblhq =  viewsub?.viewWithTag(1003) as? UILabel
        let lblcc =  viewsub?.viewWithTag(1004) as? UILabel
        let lblduration =  viewsub?.viewWithTag(1005) as? UILabel
        let imgstar =  viewsub?.viewWithTag(1006) as? UIImageView
        let lblrating =  viewsub?.viewWithTag(1007) as? UILabel
        let lbltitle =  cell.viewWithTag(1008) as? UILabel
        
        lblcc?.layer.cornerRadius = 2.5
        lblcc?.clipsToBounds = true
        lblhq?.layer.cornerRadius = 2.5
        lblhq?.clipsToBounds = true
        
        imgstar?.image = imgstar?.image?.maskWithColor(color: UIColor.white)
        
        let  theArrayIndex:Int =  indexPath.section*3+indexPath.row
        
        let isIndexValid = self.arrAllCards.indices.contains(theArrayIndex)
        
        viewsub?.isHidden = false
        imageView?.isHidden = false
        lbltitle?.isHidden = false
        
        if isIndexValid == false {
            
            viewsub?.isHidden = true
            imageView?.isHidden = true
            lbltitle?.isHidden = true
            
            return cell
        }
        let cardAtindex = self.arrAllCards[theArrayIndex]
        
        print("indxpath.row : \(indexPath.row) with section:\(indexPath.section) and arrayIndex:\(theArrayIndex)")
        
        let theImageString = "\(Constants.BASEURL)\(cardAtindex.thumbnail.path)"
        _ = imageView?.load.request(with: URL.init(string: theImageString)!)
        
        lblduration?.text = ""
        if  cardAtindex.length != nil {
            let number = NumberFormatter().number(from: cardAtindex.length!)
            let (h,m) = secondsToHoursMinutesSeconds(seconds: (number?.intValue)!)
            let strcomb = "\(h)h \(m)m"
            lblduration?.text = strcomb
        }
        
        if  cardAtindex.average_rating != nil {
           
          lblrating?.text = cardAtindex.average_rating
            
        } else {
            
            lblrating?.text = "NA"
        }
        
        lbltitle?.text = cardAtindex.name
        
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
    
    //MARK-DropDown Setup
    
    func setupDropDowns() {
        setupChooseArticleDropDown()
        //setupAmountDropDown()
        //setupChooseDropDown()
        //setupCenteredDropDown()
        //setupRightBarDropDown()
    }
    
    func setupChooseArticleDropDown() {
        chooseArticleDropDown.anchorView = chooseArticleButton
        
        // Will set a custom with instead of anchor view width
        //		dropDown.width = 100
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        chooseArticleDropDown.bottomOffset = CGPoint(x: 0, y: chooseArticleButton.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        chooseArticleDropDown.dataSource = arrLanguageDetas
        
        // Action triggered on selection
        chooseArticleDropDown.selectionAction = { [unowned self] (index, item) in
            self.chooseArticleButton.setTitle(item, for: .normal)
            self.arrAllCards = [DataMainObject]()
            self.totalPage = 0
            self.currentPage = 1
            self.selectedLanguage = item
            self.getPaginationdata()
            
        }
        
        chooseArticleDropDown.selectRow(at: 0)
        
        // Action triggered on dropdown cancelation (hide)
        //		dropDown.cancelAction = { [unowned self] in
        //			// You could for example deselect the selected item
        //			self.dropDown.deselectRowAtIndexPath(self.dropDown.indexForSelectedRow)
        //			self.actionButton.setTitle("Canceled", forState: .Normal)
        //		}
        
        // You can manually select a row if needed
        //		dropDown.selectRowAtIndex(3)
    }
    
    @IBAction func chooseArticle(_ sender: AnyObject) {
        chooseArticleDropDown.show()
    }
    lazy var dropDowns: [DropDown] = {
        return [
            self.chooseArticleDropDown//,
            //            self.amountDropDown,
            //            self.chooseDropDown,
            //            self.centeredDropDown,
            //            self.rightBarDropDown
        ]
    }()
    
    func setupDefaultDropDown() {
        DropDown.setupDefaultAppearance()
        
        dropDowns.forEach {
            $0.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self))
            $0.customCellConfiguration = nil
        }
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
                self.getPaginationdata()
            }
            
        }
        
    }
    
}
