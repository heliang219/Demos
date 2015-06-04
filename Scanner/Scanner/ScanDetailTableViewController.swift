//
//  ScanDetailTableViewController.swift
//  Scanner
//
//  Created by pfl on 15/6/3.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit

class ScanDetailTableViewController: UITableViewController {

    var fetchResultsController: NSFetchedResultsController?
    var managedObjectContext: NSManagedObjectContext?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        fetchResultsController?.delegate = self
        var error: NSError?
        fetchResultsController?.performFetch(&error)
    }

 

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
   
        if let sections = fetchResultsController?.sections
        {
            return  fetchResultsController!.sections!.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        
        if let sections = fetchResultsController?.sections
        {
            let sectionInfo: AnyObject =  sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as! UITableViewCell
        var scanItem = fetchResultsController?.objectAtIndexPath(indexPath) as! ScanItem
        
        cell.imageView?.image = UIImage(named:"scan")
        cell.textLabel?.text = scanItem.scanDetail
        cell.detailTextLabel?.text = scanItem.scanDate

        return cell
    }


    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var scanItem = fetchResultsController?.objectAtIndexPath(indexPath) as! ScanItem
        if scanItem.scanDetail.hasPrefix("http") || scanItem.scanDetail.hasPrefix("www")
        {
            UIApplication.sharedApplication().openURL(NSURL(string:scanItem.scanDetail)!)
        }
    }

    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let item = fetchResultsController?.objectAtIndexPath(indexPath) as! ScanItem
        
        self.managedObjectContext!.deleteObject(item)
        self.managedObjectContext?.save(nil)
    }
   
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    
    
    

}
        // MARK: NSFetchResultsControllerDelegate
extension ScanDetailTableViewController: NSFetchedResultsControllerDelegate
{
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type
        {
            case NSFetchedResultsChangeType.Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            case NSFetchedResultsChangeType.Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            default: break
        }
        
        
    }
}











