//
//  ToDoListViewController.swift
//  MyTodo
//
//  Created by Pankaj Kulkarni on 07/03/18.
//  Copyright © 2018 Pankaj Kulkarni. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    
    let realm = try! Realm()
    
    var toDoItems : Results<Item>?
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
    // MARK: - Table view Data Source Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
        
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                     item.done = !item.done
                }
            } catch {
                print("Error updating the date. Error: \(error)")
            }
            
        }
        
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // Once user clicks Add Item Button on the alert
            
            if let selectedCategory = self.selectedCategory {
                
                let newItem = Item()
                newItem.title = textField.text!
                
                do {
                    try self.realm.write {
                        selectedCategory.items.append(newItem)
                    }
                } catch {
                    print("Error Saving new Item. Error: \(error)")
                }
                
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New ToDo Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    


//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
    func loadItems() {

        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        navigationItem.title = selectedCategory?.name ?? "Items"

        tableView.reloadData()
    }

}

// MARK: - Search Bar delegates

extension ToDoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {

            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }


        }
    }

}
    

