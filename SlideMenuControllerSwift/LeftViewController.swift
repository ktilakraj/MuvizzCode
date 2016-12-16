//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit


enum LeftMenu: Int {
    case main = 0
    case swift
    case java
    case go
    case nonMenu
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

public struct MenuDetails {
    
    var  menuTitle:String
    var  menuId:Int
    var  subMenus = [SubmenuDetails]()
    var  isExpanded:Bool = false
    init(title:String , id:Int , isExpand:Bool, arrExpanded:AnyObject?)
    {
        menuTitle = title
        menuId = id
        isExpanded = isExpand
        let theSubMenu  = arrExpanded as? Array<AnyObject>
        for item in theSubMenu! {
            
            let theItem = item as! Dictionary<String ,AnyObject>
            let submen =  SubmenuDetails(title: theItem["Submenutitle"] as! String,id: theItem["submenuId"] as! Int)
            subMenus.append(submen)
            
        }
    }
}

public struct SubmenuDetails {
    var  subMenuTitle:String
    var  subMenuId:Int
    
    init( title:String , id:Int) {
        subMenuTitle = title
        subMenuId = id
    }
}


class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = [MenuDetails]()
    var mainViewController: UIViewController!
    var swiftViewController: UIViewController!
    var javaViewController: UIViewController!
    var goViewController: UIViewController!
    var nonMenuViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    var  isExpandedIndex:Int = -1
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getMenuData() -> Void {
        
    let path = Bundle.main.path(forResource: "sidemenu", ofType: "plist")
    let dict = NSDictionary(contentsOfFile: path!) as! [String: AnyObject]
        let tempMenus = dict["menusList"] as! [AnyObject]
       
        for menuItem in tempMenus {
            
            let theMenueItem = menuItem as! Dictionary<String,AnyObject>
            let theTitle = theMenueItem["Title"]
            let theId = theMenueItem["itemId"]
            let theIsexpanded = theMenueItem["isexpanded"] as! Bool
            let theexpendeditem = theMenueItem["expendeditem"]
            
         let menueDetails = MenuDetails(title: theTitle as! String, id: theId as! Int, isExpand: theIsexpanded, arrExpanded: theexpendeditem)
            menus.append(menueDetails)
            
        }
    print("the array:\(menus)")
    
    }
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMenuData()
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "SwiftViewController") as! SwiftViewController
        self.swiftViewController = UINavigationController(rootViewController: swiftViewController)
        
        let javaViewController = storyboard.instantiateViewController(withIdentifier: "JavaViewController") as! JavaViewController
        self.javaViewController = UINavigationController(rootViewController: javaViewController)
        
        let goViewController = storyboard.instantiateViewController(withIdentifier: "GoViewController") as! GoViewController
        self.goViewController = UINavigationController(rootViewController: goViewController)
        
        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
        nonMenuController.delegate = self
        self.nonMenuViewController = UINavigationController(rootViewController: nonMenuController)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .swift:
            self.slideMenuController()?.changeMainViewController(self.swiftViewController, close: true)
        case .java:
            self.slideMenuController()?.changeMainViewController(self.javaViewController, close: true)
        case .go:
            self.slideMenuController()?.changeMainViewController(self.goViewController, close: true)
        case .nonMenu:
            self.slideMenuController()?.changeMainViewController(self.nonMenuViewController, close: true)
        }
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isExpandedIndex == 1 {
            
            return BaseTableViewCell.height()
        }
            return 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if let menu = LeftMenu(rawValue: indexPath.row) {
//            self.changeViewController(menu)
//        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  array_atIndex:MenuDetails = menus[section]
        let viewHeader = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width:self.tableView.bounds.size.width, height: 44.0))
        viewHeader.backgroundColor = UIColor.clear
        let  lblTitle = UILabel.init(frame: CGRect.init(x: 5, y: 0, width:viewHeader.frame.size.width-10, height: viewHeader.frame.size.height))
        lblTitle.text = array_atIndex.menuTitle;
        lblTitle.textColor = UIColor.white
        lblTitle.font = UIFont.systemFont(ofSize: 18)
        viewHeader .addSubview(lblTitle)
        
        let viewHeaderSep = UIView.init(frame: CGRect.init(x: 0.0, y: viewHeader.frame.size.height-0.5, width:self.tableView.bounds.size.width, height: 0.5))
        viewHeaderSep.backgroundColor = UIColor.init(hex: "c1c1c1")
        viewHeader .addSubview(viewHeaderSep)
        
        let btnSection = UIButton.init(frame: viewHeader.bounds)
        btnSection.tag = section
        btnSection .addTarget(self, action: #selector(buttonAction(sender:)), for:UIControlEvents.touchUpInside)
        viewHeader .addSubview(btnSection)
        viewHeader.clipsToBounds = true
        return viewHeader
    }
    
    func buttonAction(sender: UIButton!) {
        let  array_atIndex:MenuDetails = menus[sender.tag]
        if  array_atIndex.menuId == 102 {
            
            if isExpandedIndex == -1 {
                isExpandedIndex = 1
            } else {
                isExpandedIndex = -1
            }
            tableView.reloadSections(IndexSet(integer: sender.tag), with: .none)
        }
        print("Button tapped\(sender.tag)")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44.0
    }
   
}

extension LeftViewController : UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
     return  menus.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        let  array_atIndex:MenuDetails = menus[section]
        return array_atIndex.subMenus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
        let viewHeaderSep = UIView.init(frame: CGRect.init(x: 10.0, y: cell.contentView.bounds.size.height-0.5, width:cell.contentView.bounds.size.width-10.0, height: 0.5))
        viewHeaderSep.backgroundColor = UIColor.init(hex: "a1a1a1")
        cell.contentView .addSubview(viewHeaderSep)
        
        let  array_atIndex:MenuDetails = menus[indexPath.section]
        let dictAtIndex = array_atIndex.subMenus[indexPath.row]
        cell.setData(dictAtIndex)
        cell.clipsToBounds = true
        cell.contentView.clipsToBounds = true
        return cell
    }
    
    
}
