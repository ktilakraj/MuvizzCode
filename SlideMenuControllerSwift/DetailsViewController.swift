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
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    
}
