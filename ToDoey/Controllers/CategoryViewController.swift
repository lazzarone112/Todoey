//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Mohamed Aboghali on 12/29/19.
//  Copyright © 2019 Mohamed Aboghali. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
       
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
        
        

    }
    
  
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textWaseet = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "type Your Category Name in the Field Under..", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textWaseet.text
            
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
            
            self.tableView.reloadData()
            
            
        }
        
        alert.addTextField { (texFields) in
            texFields.placeholder = "here.."
            textWaseet = texFields
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

    func saveCategory() {
        
        do{
          try context.save()
            
        }catch{
            print(error)
        }
        
    }
        
        func loadCategory() {
            
            let request :NSFetchRequest = Category.fetchRequest()
            
            do{
                
            categoryArray = try context.fetch(request)
            }catch{
                print(error)
            }
            tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVc = segue.destination as! ToDoListViewController
        
        if  let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVc.selectedCategory = categoryArray[indexPath.row]
            
        }
        
        
        
      }
    
}

