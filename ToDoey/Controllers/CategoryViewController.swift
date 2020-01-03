//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by Mohamed Aboghali on 1/2/20.
//  Copyright © 2020 Mohamed Aboghali. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var categoryArray = [Category]()
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToItems" {
            
            let destinatVc = segue.destination as! ToDoListViewController
            
            let indexPath = tableView.indexPathForSelectedRow
            
            destinatVc.selectedCategory = categoryArray[indexPath!.row]
            
            
        }
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textWaseet = UITextField()
        
        let alert = UIAlertController(title: "Add Category..", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            
            textField.placeholder = "add Category"
            textWaseet = textField
       
        }
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textWaseet.text
            
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
            
            self.tableView.reloadData()
            
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
        
        let request:NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    
}
