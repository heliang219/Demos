//
//  ViewController.swift
//  SwiftStudy
//
//  Created by pfl on 15/10/22.
//  Copyright © 2015年 pfl. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    enum SegueIdentifier: String {
        case second
        case third
        case other
    }

    
    lazy private var tableView:UITableView = {
        let tableView: UITableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource,SegueHandlerType {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(UITableViewCell)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row%2 == 0 {
           performSegueWithIdentifier(.second, sender: nil)
        }
        else {
           performSegueWithIdentifier(.third, sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let segueIdentifier = segueIdentifierForSegue(segue)
        switch segueIdentifier {
        case .second:
            let secondVC = segue.destinationViewController as! SecondViewController
            secondVC.index = 1
            
        case .third:
            let _ = segue.destinationViewController as! ThirdViewController
            
        default:
            break
        }
        
    }

    

}

extension NSObject {
    static var className:String {
        get {
            let identifier = self.description().componentsSeparatedByString(".").last!
            return identifier
        }
    }
}

extension UITableView {
    func dequeueReusableCell<T:UITableViewCell>(cell:T.Type)->T {
        return dequeueReusableCellWithIdentifier(cell.className) as! T
    }
}

protocol SegueHandlerType {
    typealias SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController,SegueIdentifier.RawValue == String {
    func performSegueWithIdentifier(segue: SegueIdentifier, sender: AnyObject?) {
        performSegueWithIdentifier(segue.rawValue, sender: sender)
    }
    
    func segueIdentifierForSegue(segue:UIStoryboardSegue)->SegueIdentifier {
        guard
            let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
                fatalError("")
        }
        return segueIdentifier
    }
    
}












