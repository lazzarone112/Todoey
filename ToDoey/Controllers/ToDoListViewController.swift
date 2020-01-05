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

    let realm = try! Realm()
    
    var itemArray = [Item]()
    
    var selectedCategory :Category? {
        didSet{
//            loadItems()
            
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
        
//        loadItems()
        
        
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
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//
//       saveItems()
//
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
                print(error)
            }
//

           

            print(self.itemArray)
            self.tableView.reloadData()

        }
//
//
        alert.addAction(action)
        alert.addTextField { (textField) in
            textField.placeholder = "Here : )"
            textWaseet = textField
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
//    func saveItems() {
//
//                   do{
//                    try context.save()
//                   }catch{
//                       print(error)
//                   }
//
//    }
    
//    func loadItems(with request:NSFetchRequest<Item> = Item.fetchRequest(),Predicate:NSPredicate? = nil) {
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = Predicate {
//
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
//        }else{
//            request.predicate = categoryPredicate
//        }
//        do{
//            itemArray = try context.fetch(request)
//
//
//
//        }catch{
//            print(error)
//        }
//        tableView.reloadData()
//    }
//
//
//
//}
}

extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        

    }
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request:NSFetchRequest = Item.fetchRequest()
//
//               let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//               request.predicate = predicate
//
//        let sortDiscriptor = NSSortDescriptor(key: "title", ascending: true)
//
//        request.sortDescriptors = [sortDiscriptor]
//
//             loadItems(with: request, Predicate: predicate)
//
//                tableView.reloadData()
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                if searchBar.text?.count == 0{
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
//                self.loadItems()
            }
        }
        
    }
}
