//
//  TableViewCell.swift
//  swarajya.todo<swapnil>
//
//  Created by Mac on 31/01/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    

    
    @IBOutlet weak var btnimgage: UIButton!
    @IBAction func btnfavorite(_ sender: UIButton) {
         let image = UIImage(named: "star.jpg")
        let image1 = UIImage(named: "bstar.jpg")
        if((btnimgage.currentBackgroundImage) == image1)
        {
              //   let createQuery = "create table if not exists tasktable(taskname text,dayname text,status text)"
            let updateQuery = "update tasktable set status = 'true'  where taskname = '\(lbltask.text!)'"
            let isSuccess = SQLDatabase.sharedObject.executeQuery(query: updateQuery)
            if isSuccess
            {
                print("successfully updated in database")
            }
            else
            {
                print("updating Failed")
            }
//        btnimgage.setImage(image, for: .normal)
        //print("\(lbltask.text)")
        btnimgage.setBackgroundImage(image, for: .normal)
        }
        else
        {
            let updateQuery = "update tasktable set status = 'false'  where taskname = '\(lbltask.text!)'"
            let isSuccess = SQLDatabase.sharedObject.executeQuery(query: updateQuery)
            if isSuccess
            {
                print("successfully status change in database")
            }
            else
            {
                print("updating Failed")
            }
            //        btnimg
            btnimgage.setBackgroundImage(image1, for: .normal)
        }
       // btnimgage.setTitle("😊🌸", for: .normal)
     //   btnimgage.titleLabel?.text = "😊"
    }
    @IBOutlet weak var lbltask: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblday: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
