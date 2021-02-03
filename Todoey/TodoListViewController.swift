//
//  ViewController.swift
//  Todoey
//
//  Created by Yogesh Raut on 02/02/21.
//

import UIKit

class TodoListViewController: UITableViewController {

    var shoppingList = ["Buy Cocount Oil", "Buy a Soap", "Buy Apple"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    //MARK - TableView Datasource Method

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        
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
}

