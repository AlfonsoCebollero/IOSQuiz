//
//  PistasTableViewController.swift
//  practica5
//
//  Created by Marina Cebollero on 21/12/18.
//  Copyright © 2018 g818. All rights reserved.
//

import UIKit

class PistasTableViewController: UITableViewController {
    
    
    var inheritedTips = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return inheritedTips.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipCell", for: indexPath)
        
        
        let tip = inheritedTips[indexPath.row]
        title = "Tips"
        cell.textLabel?.text = tip
        return cell
    }
    

}
