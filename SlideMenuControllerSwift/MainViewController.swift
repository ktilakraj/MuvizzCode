//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
     var items: [Int] = []
     var storedOffsets = [Int: CGFloat]()
    
    
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnMenue: UIButton!
    var mainContens = ["data1", "Free", "Pay Per View", "Subscription", "Bundles", "Recently Added"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.tableView.registerCellClass(DataTableViewCell.self)
        //self.tableView.registerCellClass(MastHeadCrousalCell.self)
        let  menuImage:UIImage = (btnMenue.imageView?.image)!
            btnMenue .setImage(menuImage.maskWithColor(color: UIColor.white), for: UIControlState.normal)
        
        
        
    }
    
    @IBAction func btnMenuClick(_ sender: AnyObject) {
       
         self.openLeft()
    }
    @IBAction func btnSearchClick(_ sender: AnyObject) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for i in 0 ... 10 {
            items.append(i)
        }
    }


    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
       
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            
            return MastHeadCrousalCell.height()
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
        return self.mainContens.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MastHeadCrousalCell.identifier) as! MastHeadCrousalCell
            cell.setData(items)
            return cell;
            
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.identifier) as! DataTableViewCell
        //let data = DataTableViewCellData(imageUrl: "dummy", text: mainContens[indexPath.row])
            
            cell.setCellData(items,sectionTitle: mainContens[indexPath.row])
            cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell;
        }
        return UITableViewCell()
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
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollection",
                                                      for: indexPath)
        
        //cell.te = items [indexPath.row]
        
        return cell
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
