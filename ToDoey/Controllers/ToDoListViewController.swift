//
//  ViewController.swift
//  ToDoey
//
//  Created by Mohamed Aboghali on 12/16/19.
//  Copyright © 2019 Mohamed Aboghali. All rights reserved.
//

import UIKit
import  CoreData
import RealmSwift



class ToDoListViewController: UITableViewController{

    let defaultx = UserDefaults.standard
    
    var itemArray : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
//
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//
       
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        searchBar.delegate = self
        
        loadItems()
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray?[indexPath.row].title
        if itemArray?[indexPath.row].done == true {
           cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = itemArray?[indexPath.row] {
            do {
               try realm.write {
                    item.done = !item.done
                }
            }catch{
                print(error)
            }
        }
        
        tableView.reloadData()
        
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textWaseet = UITextField()
        
        let alert = UIAlertController(title: "Add a Task", message: "Add Your Task Name In The Field Under!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            do{
                try self.realm.write {
            let newItem = Item()
             newItem.title = textWaseet.text!
            self.selectedCategory?.items.append(newItem)
            }
           
            }catch{
                print (error)
                
            }
            
            
//            self.defaultx.setValue(self.itemArray, forKey: "ToDoListDefault")
        
            
//            print(self.itemArray)
               self.tableView.reloadData()
            
        }
        
        
        alert.addAction(action)
        alert.addTextField { (textField) in
            textField.placeholder = "Here : )"
            textWaseet = textField
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func saveItems() {
       
                   do{
                    try context.save()
                   }catch{
                       print(error)
                   }
        
    }
    
    func loadItems() {
        
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
//
//
//
//}
}

extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
       
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        itemArray = itemArray?.filter(NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)).sorted(byKeyPath: "date", ascending: true)
            tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.loadItems()
            }
        }
        
    }
}
