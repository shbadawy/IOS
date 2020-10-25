//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Shimaa Badawy on 10/21/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class CategoryViewController:SwipeCellViewController {
    
    let realm = try! Realm()
    var itemList: Results<Category>?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let navBar = navigationController?.navigationBar else {fatalError()}
        
        navBar.backgroundColor = UIColor(hexString: "1D9BF6")
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:  UIColor.white ]
        navBar.tintColor = UIColor.white
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemList?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = itemList?[indexPath.row].name ?? "No categories added"
        
        if let item = itemList?[indexPath.row] {
            
            cell.accessoryType = .disclosureIndicator
            
            if let color = UIColor(hexString: item.color){
                    
                    cell.backgroundColor = color
                    cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
                    
                }
                
        }
     
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: K.itemViewSegue, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let distinationVC = segue.destination as! TodoViewController
        if let index = tableView.indexPathForSelectedRow {
            
            distinationVC.category = itemList?[index.row]
            
        }
        
    }
    
    //MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat().hexValue()
            
            do{
                
                try self.realm.write{
                    
                    self.realm.add(newCategory)
                    
                }
                
            }catch{
                print("Error writing data \(error)")
            }
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (text) in
            
            textField = text
            textField.placeholder = "Write the category name"
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Data manipulation
    
    func loadData()  {
        
        itemList = realm.objects(Category.self)
        tableView.reloadData()
        
    }
    
    override func updateData(with indexPath: IndexPath) {
        
        do{
            try self.realm.write{
                if let item = self.itemList?[indexPath.row]{
                    self.realm.delete(item)
                }
                
            }
        }catch{print("Error deleting data \(error)")}
        
    }
    
}

