//
//  ViewController.swift
//  Todoey
//
//  Created by Yogesh Raut on 02/02/21.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    @IBOutlet weak var listItemButton: UIBarButtonItem!
    var userDefaults = UserDefaults.standard
    
    @IBOutlet weak var todoListSearchBar: UISearchBar!
    var shoppingList = [Items]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
           
    }
    
    //MARK - TableView Datasource Method

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
        let item = shoppingList[indexPath.row]
        cell.textLabel?.text = item.title
        
        return cell
    }
    
    // MARK - Tableview Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(shoppingList[indexPath.row])
       /* if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }*/
        
        context.delete(shoppingList[indexPath.row])
        shoppingList.remove(at: indexPath.row)
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - UIBar Button Item Click Event.
    @IBAction func barButtonClick_event(_ sender: UIBarButtonItem) {
        var tempAlertTextField = UITextField()
        let alert = UIAlertController(title: "", message: "Please add To do List Item", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
            print("Okay Button Clicked",(tempAlertTextField.text)!)
            
            let newItem = Items(context: self.context)
            newItem.title = tempAlertTextField.text ?? ""
            newItem.done = false
            self.shoppingList.append(newItem)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            tempAlertTextField = alertTextField
        }
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveData() {
        do{
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
    }
    
    func loadItems(with request : NSFetchRequest<Items> = Items.fetchRequest())  {
        
        do {
          shoppingList =  try context.fetch(request)
        
        }catch {
            print("Unaable to load data\(error)")
        }
        
        tableView.reloadData()
    }
}

extension TodoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Items> = Items.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            loadItems()
            
        }
    }
}

