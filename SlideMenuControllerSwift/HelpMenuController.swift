//
//  NonMenuController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit



class HelpMenuController: UIViewController {
    
    @IBOutlet weak var tblHelp: UITableView!
    weak var delegate: LeftMenuProtocol?
    let arroptions = ["About Us","Contact Us","Privacy","Terms"]
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var btnsearch: UIButton!
    @IBOutlet weak var btnback: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    tblHelp.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    @IBAction func btnsearchclick(_ sender: AnyObject) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.removeNavigationBarItem()
        //self.setNavigationBarItem()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
  
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            guard let vc = (self.slideMenuController()?.mainViewController as? UINavigationController)?.topViewController else {
                return
            }
            if vc.isKind(of: HelpMenuController.self)  {
                self.slideMenuController()?.removeLeftGestures()
                self.slideMenuController()?.removeRightGestures()
            }
        })
    }
  
    @IBAction func didTouchToMain(_ sender: UIButton) {
        delegate?.changeViewController(LeftMenu.main)
    }
}

//MARK:Table view data source

extension HelpMenuController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arroptions.count;
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHelp", for: indexPath)
        cell.textLabel?.text = arroptions[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
}

extension HelpMenuController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("the selected indexpath \(indexPath.row)")
    }
}

