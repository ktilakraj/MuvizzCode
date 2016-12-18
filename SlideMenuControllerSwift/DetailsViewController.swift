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
    
    
    @IBOutlet weak var chooseArticleButton: UIButton!
    let chooseArticleDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropDwonInitialSetup()
    }
    
    
    func dropDwonInitialSetup() -> Void {
        
        setupDropDowns()
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .any }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        setupData()
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
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 3
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellDetails", for: indexPath)
        
        return cell
    }
    
     public func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 10;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let heightCal = (collectionView.frame.size.height/collectionView.frame.size.width)*(collectionView.frame.size.width/3.2)
       return CGSize(width: collectionView.frame.size.width/3.2, height: heightCal)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "FinalDetailViewController") as! FinalDetailViewController
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
        chooseArticleDropDown.dataSource = [
            "All",
            "Hindi",
            "English",
            "Telgu",
            "Bengali",
            "Marathi",
            "Panjabi",
            "Urdu",
            "Kannada",
            "Tamil",
            "Japness",
            "French",
            "Arabic",
            "Spanish",
            "Chinese",
            "German",
            "Polish",
            "Dari"
        ]
        
        // Action triggered on selection
        chooseArticleDropDown.selectionAction = { [unowned self] (index, item) in
            self.chooseArticleButton.setTitle(item, for: .normal)
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

}
