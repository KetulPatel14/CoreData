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
    
    var models = []()
    
    @IBOutlet weak var myTable: UITableView!
    @IBAction func addBtn(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myTable.delegate = self
        myTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

