//
//  ViewController.swift
//  ToDoey
//
//  Created by Mohamed Aboghali on 12/16/19.
//  Copyright © 2019 Mohamed Aboghali. All rights reserved.
//

import UIKit




class ToDoListViewController: UITableViewController{

    let defaultx = UserDefaults.standard
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//
        if let items = defaultx.array(forKey: "ToDoListDefault") as? [Item] {
            itemArray = items
        }
        print(dataFilePath)
        loadItems()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        if itemArray[indexPath.row].done == true {
           cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       saveItems()
        
        tableView.reloadData()
        
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textWaseet = UITextField()
        
        let alert = UIAlertController(title: "Add a Task", message: "Add Your Task Name In The Field Under!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textWaseet.text!
            self.itemArray.append(newItem)
//            self.defaultx.setValue(self.itemArray, forKey: "ToDoListDefault")
           
            self.saveItems()
            
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
    
    func saveItems() {
        let encoder = PropertyListEncoder()
                   do{
                       let data = try encoder.encode(self.itemArray)
                       try data.write(to: self.dataFilePath!)
                   }catch{
                       print(error)
                   }
        
    }
    
    func loadItems() {
        
        if  let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self, from: data)
        }catch{
            print(error.self)
        }
        
    }
    
    

}
}
