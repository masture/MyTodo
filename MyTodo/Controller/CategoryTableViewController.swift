//
//  CategoryTableViewController.swift
//  MyTodo
//
//  Created by Pankaj Kulkarni on 08/03/18.
//  Copyright © 2018 Pankaj Kulkarni. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()

    }

    // MARK: Table View Datasource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell

    }
    
    // MARK: Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destnationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destnationVC.selectedCategory = categories[indexPath.row]
            
        }
    }
    
    // MARK: Data Manipulation Methods
    func saveCategories() {
        
        do {
            
            try context.save()

        }
        catch {
            print("Error saving categories. Error:\(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching categories data. Error: \(error)")
        }
        
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
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    


    
}
