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
        initializeDogs()
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
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Remove dog at source indexpath in dogs array so shits not jacked up
        let dog = dogs.remove(at: sourceIndexPath.row)
        // Insert it at the destination indexPath
        dogs.insert(dog, at: destinationIndexPath.row)
        // reload tableview cus you're the boss and you can
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dogs.remove(at: indexPath.row)
        
        // Delete tableView row
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check for Segue identifier
        if let identifier  = segue.identifier {
            if identifier == "DetailSegue" {
                if let dogDetailVC = segue.destination as? DogDetailViewController {
                    if let indexPath = tableView.indexPathForSelectedRow {
                        // This is the dog that the user taps on
                        let dog = dogs[indexPath.row]
                        // Send over the dog the user tapped on to the dogOptional in DogDetailViewController
                        dogDetailVC.dogOptional = dog
                    }
                }
                else if identifier == "AddSegue" {
                    if let indexPath = tableView.indexPathForSelectedRow {
                        tableView.deselectRow(at: indexPath, animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func unwindToDogTableViewController(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            if identifier == "SaveUnwindSegue" {
                if let dogDetailVC = segue.source as? DogDetailViewController {
                    if let dog = dogDetailVC.dogOptional {
                        // If there is a selected row
                        if let indexPath = tableView.indexPathForSelectedRow {
                            dogs[indexPath.row] = dog
                        } else {
                        // There is no selected row
                        // -> Unwinding from AddSegue
                            dogs.append(dog)
                        }
                        // Force refresh
                        tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        // Inverses current editing mode by making it !(not) whatever it is.
        let newEditingMode = !tableView.isEditing
        tableView.setEditing(newEditingMode, animated: true)
    }

    
}

