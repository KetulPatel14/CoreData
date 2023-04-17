//
//  ViewController.swift
//  CoreDataApp
//
//  Created by Canadore Student on 2023-04-17.
//  Copyright © 2023 Canadore Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var models = [ToDoListItem]()
    
    @IBOutlet weak var myTable: UITableView!
    @IBAction func addBtn(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Form", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: {[weak self] _ in
        
            guard
                let field1 = alert.textFields?[0],
                let field2 = alert.textFields?[1],
                let text1 = field1.text,
                let text2 = field2.text,
                !text1.isEmpty,
                !text2.isEmpty
                else {
                    return
            }
            self?.createItem(fName: text1, lName: text2)
        
        }))
        present(alert, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getAllItems()
        
        myTable.delegate = self
        myTable.dataSource = self
    }
    
    // get all item function
    
    func getAllItems() {
        do{
            models = try context.fetch(ToDoListItem.fetchRequest())
            myTable.reloadData()
        }catch{
            // error
        }
    }
    
    // createItem function
    
    func createItem(fName: String, lName: String)
    {
        let newItem = ToDoListItem(context: context)
        newItem.fName = fName
        newItem.lName = lName
        
        do{
            try context.save()
            getAllItems()
        }
        catch
        {
            
        }
    }
    
    //deleteItem function
    
    func deleteItem(item: ToDoListItem)
    {
        context.delete(item)
        do{
            try context.save()
            getAllItems()
        }
        catch
        {
            
        }
    }
    
    // updateItem function
    
    func updateItem(item: ToDoListItem, newFName: String,newLName: String )
    {
        item.fName = newFName
        item.lName = newLName
        do{
            try context.save()
            getAllItems()
        }
        catch
        {
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = model.fName
        cell.detailTextLabel?.text = model.lName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Display Alert Box..
        let item = models[indexPath.row]
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            // Display Alert Box for Edit ..
            let alert = UIAlertController(title: "Edit Item", message: "Edit Your Item", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.fName
            alert.textFields?[1].text = item.lName
            alert.addAction(UIAlertAction(title: "Save", style: .cancel,handler: { [weak self] _ in
                guard
                    let field1  = alert.textFields?.first,
                    let field2  = alert.textFields?[1],
                    let newFName = field1.text,
                    let newLName = field2.text,
                    !newFName.isEmpty,
                    !newLName.isEmpty
                    else{
                        return
                }
                
                self?.updateItem(item: item, newFName: newFName, newLName: newLName)
            }))
            
            self.present(alert,animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        
        present(sheet,animated: true)
    }

}


