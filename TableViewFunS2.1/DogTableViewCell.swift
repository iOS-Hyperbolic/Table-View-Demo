//
//  DogTableViewCell.swift
//  TableViewFunS2.1
//
//  Created by Karsen Hansen on 11/11/20.
//

import UIKit

class DogTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var breedLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with dog: Dog) {
        nameLabel.text = dog.name
        breedLabel.text = dog.breed
    }
}
