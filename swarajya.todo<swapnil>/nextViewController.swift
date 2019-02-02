//
//  nextViewController.swift
//  swarajya.todo<swapnil>
//
//  Created by Mac on 01/02/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class nextViewController: UIViewController {
    
    
    @IBOutlet weak var btnsave: UIButton!
    
    @IBOutlet weak var txttask: UITextField!
    @IBAction func btnsaveAct(_ sender: UIButton)
    {
       
     //   let createQuery = "create table if not exists tasktable(taskname text,dayname text,status text)"
        let insertQuery = "insert into tasktable(taskname,dayname,status) values ('\(txttask.text!)','\(lblday.text!)','false')"
        let isSuccess = SQLDatabase.sharedObject.executeQuery(query: insertQuery)
        if isSuccess
        {
            print("successfully insert in database")
        }
        else
        {
            print("data Failed")
        }
    }
    @IBOutlet weak var datepicker: UIDatePicker!
    
    @IBOutlet weak var lblday: UILabel!
    
    @IBAction func dayAction(_ sender: UIDatePicker) {
       
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        lblday.text = result
//        var date = DateTime.Now
//        lblday.text = date
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        lblday.text = result
       // btnsave.layer =
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
