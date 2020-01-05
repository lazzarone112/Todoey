//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Mohamed Aboghali on 12/29/19.
//  Copyright © 2019 Mohamed Aboghali. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift


class CategoryViewController: UITableViewController {
    
    var categoryArray : Results<Category>?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
       
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Category Added Yet.."
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
        
        

    }
    
  
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textWaseet = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "type Your Category Name in the Field Under..", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            
            newCategory.name = textWaseet.text!
            
            
            self.saveCategory(category: newCategory)
            
            self.tableView.reloadData()
            
            
        }
        
        alert.addTextField { (texFields) in
            texFields.placeholder = "here.."
            textWaseet = texFields
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

    func saveCategory(category:Category) {
        
        do{
            try realm.write {
                realm.add(category)
            }
            
        }catch{
            print(error)
        }
        
    }
        
        func loadCategory() {
            
            
            categoryArray = realm.objects(Category.self)
         
            tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVc = segue.destination as! ToDoListViewController
        
        if  let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVc.selectedCategory = categoryArray?[indexPath.row]
            
        }
        
        
        
      }
    
}

