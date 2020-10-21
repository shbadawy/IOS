//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Shimaa Badawy on 10/21/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemList = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryReusbleCell, for: indexPath)
        
        cell.textLabel?.text = itemList[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.itemList.append(newCategory)
            self.saveData()
            
        }
        
        alert.addTextField { (text) in
            
            textField = text
            textField.placeholder = "Write the category name"
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func loadData(with request : NSFetchRequest<Category> = Category.fetchRequest())  {
        
        do {
            itemList = try context.fetch(request)
        }catch{
            print("Error loading data \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func saveData() {
        
        do{
        try context.save()
        }catch{
            print("Error \(error)")
        }
        
        tableView.reloadData()
        
    }
    
}
