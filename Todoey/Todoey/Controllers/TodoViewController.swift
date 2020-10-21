//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoViewController: UITableViewController{
        
    @IBOutlet weak var search_Bar: UISearchBar!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //let data = UserDefaults.standard
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //.first?.appendingPathComponent("items.plist")
    
    var itemsList = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search_Bar.delegate = self
        loadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCell , for: indexPath)
        let item = itemsList[indexPath.row]

        cell.textLabel?.text = item.text

        cell.accessoryType = item.checked ? .checkmark : .none
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = itemsList[indexPath.row]
        selectedItem.setValue(!selectedItem.checked, forKey: "checked")
        tableView.deselectRow(at: indexPath, animated: true)
        saveData()
        
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        
        var textFieldText = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "",preferredStyle: .alert )
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
           
            let newItem = Item(context: self.context)
            
            newItem.text = textFieldText.text!
            newItem.checked = false
            
            self.itemsList.append(newItem)
            self.saveData()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Write an item to-do"
            textFieldText = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion:nil)
        
    }
    
    func saveData() {
        
        do{
            
        try context.save()
            
        }catch{
            
            print("Error")
            
        }
        
        
        self.tableView.reloadData()
        
    }
    
    func loadData(with request : NSFetchRequest <Item> = Item.fetchRequest())  {

        
        do{
        itemsList = try context.fetch(request)
        }catch{
            print("Error \(error)")
        }

        tableView.reloadData()

    }
    
    
}

extension TodoViewController:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                
        let request:NSFetchRequest <Item> = Item.fetchRequest()

        request.predicate = NSPredicate(format: "text CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]

        loadData(with: request)
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
        searchBar.text = ""
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {loadData()}
        
        
    }
    
    
}
