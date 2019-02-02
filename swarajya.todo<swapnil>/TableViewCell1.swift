//
//  TableViewCell1.swift
//  swarajya.todo<swapnil>
//
//  Created by Mac on 02/02/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TableViewCell1: UITableViewCell {

    @IBAction func btnshow(_ sender: UIButton) {
    }
    @IBOutlet weak var btnimg: UIButton!
    @IBOutlet weak var lblday: UILabel!
    @IBOutlet weak var lbltask: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
