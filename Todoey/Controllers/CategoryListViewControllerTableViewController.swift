//
//  CategoryListViewControllerTableViewController.swift
//  Todoey
//
//  Created by Yogesh Raut on 15/01/24.
//

import UIKit
import CoreData


class CategoryListViewControllerTableViewController: UITableViewController {
    @IBOutlet weak var categoryButton: UIBarButtonItem!
    
    @IBOutlet var categoryTableView: UITableView!
    
    var categoryList = [Categories]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
      print("I am here")
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        loadItems()
    }
    
    func saveCatgegories() {
        do{
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
       
    }

    @IBAction func categoryButtonClicked(_ sender: UIBarButtonItem) {
        var tempAlertTextField = UITextField()
        let alert = UIAlertController(title: "Please add Category here", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
            print("Okay Button Clicked",(tempAlertTextField.text)!)
            
            let newItem = Categories(context: self.context)
            newItem.name = tempAlertTextField.text ?? ""
            self.categoryList.append(newItem)
            self.saveCatgegories()
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            tempAlertTextField = alertTextField
        }
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems(with request : NSFetchRequest<Categories> = Categories.fetchRequest())  {
        
        do {
          categoryList =  try context.fetch(request)
        
        }catch {
            print("Unaable to load data\(error)")
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryItems", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = categoryList[indexPath.row].name

        return cell
    }
    
    // MARK: - TableView Delegate Method
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDoList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryList[indexPath.row]
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
