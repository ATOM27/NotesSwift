//
//  NoteTableViewController.swift
//  NotesSwift
//
//  Created by Eugene Mekhedov on 26.09.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.estimatedRowHeight = 120.0 // standard tableViewCell height
//        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var fetchRequest: NSFetchRequest<NSManagedObject>?{
        get{
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Notes")
            
            // Set the batch size to a suitable number.
            fetchRequest.fetchBatchSize = 20
            
            // Edit the sort key as appropriate.
            let sortDescriptor = NSSortDescriptor(key: "header", ascending: true)
            
            fetchRequest.sortDescriptors = [sortDescriptor]
            return fetchRequest}
        set{}
    }
    
    //MARK: UITableViewDataSource
    
    override func configureCell(_ cell: UITableViewCell, withObject object: NSManagedObject) {
        let cell = cell as! NoteTableViewCell
        let object = object as! Notes
        
        cell.headerLabel.text = object.header
        cell.descriptionTextView.text = object.descriptionNote
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseIdentifierr) as! NoteTableViewCell
        let noteManagedObject = fetchedResultsController.object(at: indexPath) as? Notes
        cell.headerLabel.text = noteManagedObject?.header ?? ""
        cell.descriptionTextView.text = noteManagedObject?.descriptionNote ?? ""

//        cell.setNeedsUpdateConstraints()
//        cell.updateConstraintsIfNeeded()
        
        return cell
    }
}
