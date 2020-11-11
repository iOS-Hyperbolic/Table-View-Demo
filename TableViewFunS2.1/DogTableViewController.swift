//
//  ViewController.swift
//  TableViewFunS2.1
//
//  Created by Karsen Hansen on 11/11/20.
//

import UIKit

class DogTableViewController: UIViewController {
    
    var dogs = [Dog]()
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func initializeDogs() {
        dogs.append(Dog(name: "Lassie", breed: "Collie"))
        dogs.append(Dog(name: "Siggy", breed: "Malamute"))
        dogs.append(Dog(name: "Annie", breed: "Sheltie"))
    }

}

