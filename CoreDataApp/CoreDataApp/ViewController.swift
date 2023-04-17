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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    
    func createItem(name: String)
    {
        let newItem = ToDoListItem(context: context)
        newItem.fName = name
        newItem.lName = name
        
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
    
    func updateItem(item: ToDoListItem, newName: String)
    {
        item.fName = newName
        item.lName = newName
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


}

