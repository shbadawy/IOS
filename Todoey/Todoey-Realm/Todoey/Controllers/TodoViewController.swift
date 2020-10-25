//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class TodoViewController: SwipeCellViewController{
    
    @IBOutlet weak var search_Bar: UISearchBar!
    
    let realm = try! Realm()
    
    var category:Category? {
        
        didSet{
            
            loadData()
            
        }
        
    }
    
    var itemsList: Results<Item>?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        search_Bar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        title = category?.name
        guard let navBar = navigationController?.navigationBar else { fatalError()}
        
        if let hexColor = category?.color {
            if let color = UIColor(hexString: hexColor){
                
                let contrastColor =  ContrastColorOf(color, returnFlat: true)
                navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: contrastColor]
                navBar.backgroundColor = color
                search_Bar.barTintColor = color
                navBar.tintColor = contrastColor
                
            }
            
        }
        
    }
    //MARK: - table DataSources methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  itemsList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = itemsList?[indexPath.row].title ?? "No items added"
        cell.accessoryType = itemsList?[indexPath.row].done == true ? .checkmark : .none
        if let categoryColor = UIColor(hexString: category!.color){
            if let backColor = categoryColor.darken(byPercentage: CGFloat(indexPath.row)/CGFloat(itemsList!.count)){
                
                cell.backgroundColor = backColor
                cell.textLabel?.textColor = ContrastColorOf(backColor, returnFlat: true )
                
            }
            
            
            
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        do {
            try realm.write{
                
                itemsList?[indexPath.row].done = !(itemsList?[indexPath.row].done)!
                
            }
        }catch{print("Error updating data \(error)")}
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
    }
    //MARK: - Actions
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        
        var textFieldText = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "",preferredStyle: .alert )
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            
            let newItem = Item()
            
            do{
                
                try self.realm.write{
                    
                    newItem.title = textFieldText.text!
                    newItem.dateCreated = Date()
                    self.category?.items.append(newItem)
                    self.realm.add(newItem)
                    
                }
                
            }catch{
                
                print("Error saving data \(error)")
                
            }
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Write an item to-do"
            textFieldText = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion:nil)
        
    }
    //MARK: - Data manipulating
    
    func loadData()  {
        
        itemsList = category?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        
    }
    
    override func updateData(with indexPath: IndexPath) {
        do{
            try self.realm.write{
                self.realm.delete(self.itemsList![indexPath.row])
                
            }
        }catch{print("Error deleting data \(error)")}
        
    }
    
    
}

//MARK: - Search
extension TodoViewController:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let predicate = NSPredicate (format: "text CONTAINS[cd] %@", searchBar.text!)
        
        itemsList = itemsList?.filter(predicate).sorted(byKeyPath: "dateCreated", ascending: true)
        //loadData(predicate: predicate)
        
        tableView.reloadData()
        
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if itemsList?.count == 0 {
            
            loadData()
            
        }
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
        
    }
    
    
}

