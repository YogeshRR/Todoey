//
//  ViewController.swift
//  Todoey
//
//  Created by Yogesh Raut on 02/02/21.
//

import UIKit

class TodoListViewController: UITableViewController {
    @IBOutlet weak var listItemButton: UIBarButtonItem!
    var userDefaults = UserDefaults.standard
    
    var shoppingList = [Items]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let newItem = Items()
//        newItem.title = "By Onion"
//        newItem.done = true
//        shoppingList.append(newItem)
        
        if let shoppingListArray = userDefaults.array(forKey: "shoppingListName") as? [Items] {

            shoppingList = shoppingListArray
        }
           
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
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - UIBar Button Item Click Event.
    @IBAction func barButtonClick_event(_ sender: UIBarButtonItem) {
        var tempAlertTextField = UITextField()
        let alert = UIAlertController(title: "", message: "Please add To do List Item", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
            print("Okay Button Clicked",(tempAlertTextField.text)!)
            let newItem = Items()
            newItem.title = tempAlertTextField.text ?? ""
            self.shoppingList.append(newItem)
            //self.userDefaults.set(self.shoppingList, forKey: "shoppingListName")
            self.userDefaults.set(self.shoppingList, forKey: "shoppingListName") as? [Items]
            self.userDefaults.synchronize()
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            tempAlertTextField = alertTextField
        }
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

