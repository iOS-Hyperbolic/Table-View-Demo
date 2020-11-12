//
//  ViewController.swift
//  TableViewFunS2.1
//
//  Created by Karsen Hansen on 11/11/20.
//

import UIKit

class DogTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // The TableView is asking its data source:
        /// "How many row should I put in this section?"
        // We will only have one section
        if section == 0 {
            return dogs.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TableView is asking its data source
        /// "What cell should I put at this index path?"
        // IndexPath has 2 properties
        /// 1. Section number
        /// 2. Row number (corresponds to array index)
        let row = indexPath.row
        let dog = dogs[row]
        
        // Force down-cast to DogTableView cell to call update method in DogTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as! DogTableViewCell
        
        // Why a reusable cell?
        // If dogs had 10k dogs listed, we wouldn't need 10k cells.
        // iOS creates pool of 'reusable' cells and only creates enough to fill the display.
        // As rows exit the display they enter a reusable 'pool' which they are then taken from to use for new cells entering the display during scrolling.
        
        cell.update(with: dog)
        return cell
    }
    

}

