//
//  ViewController.swift
//  ToDoey
//
//  Created by Mohamed Aboghali on 12/16/19.
//  Copyright © 2019 Mohamed Aboghali. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Study","WorkOut","Read"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textWaseet = UITextField()
        
        let alert = UIAlertController(title: "Add a Task", message: "Add Your Task Name In The Field Under!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            self.itemArray.append(textWaseet.text!)
            print(self.itemArray)
            self.tableView.reloadData()
            
        }
        alert.addAction(action)
        alert.addTextField { (textField) in
            textField.placeholder = "Here : )"
            textWaseet = textField
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    

}

