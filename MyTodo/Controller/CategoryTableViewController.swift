//
//  CategoryTableViewController.swift
//  MyTodo
//
//  Created by Pankaj Kulkarni on 08/03/18.
//  Copyright © 2018 Pankaj Kulkarni. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()

    }

    // MARK: Table View Datasource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added yet"
        
        return cell

    }
    
    // MARK: Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destnationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destnationVC.selectedCategory = categories?[indexPath.row]
            
        }
    }
    
    // MARK: Data Manipulation Methods
    func save(category : Category) {
        
        do {
            
            try realm.write {
                realm.add(category)
            }

        }
        catch {
            print("Error saving categories. Error:\(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        

        categories = realm.objects(Category.self)

        tableView.reloadData()
        
    }
    
    // MARK: Add New Category

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // To store the reference of the textfield added on the alert controller
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (inputTextField) in
            
            inputTextField.placeholder = "Create New Category"
            // Store the reference.
            textField = inputTextField
            
        }
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // Once user presses Add Category button
            
            let newCategory = Category()
            newCategory.name = textField.text!
  
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    


    
}
