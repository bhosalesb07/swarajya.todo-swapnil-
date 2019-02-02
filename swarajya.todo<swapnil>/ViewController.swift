//
//  ViewController.swift
//  swarajya.todo<swapnil>
//
//  Created by Mac on 31/01/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableview: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArray1.count
    }
  override  func viewWillAppear(_ animated: Bool) {
    let selectQuery =  "select * from tasktable"
    SQLDatabase.sharedObject.SelectAllTask(query: selectQuery)
    selectedArray1 = SQLDatabase.sharedObject.SelectedArray!
    selectedDayArray = SQLDatabase.sharedObject.DayArray!
    selectedtaskArray = SQLDatabase.sharedObject.TaskArray!
    if(selectedtaskArray.count > 0)
    {
        
        print(selectedArray1)
        print(selectedDayArray)
        print(selectedtaskArray)
    }
    tableview.reloadData()
    
    }
    
    @IBAction func fav1(_ sender: UIBarButtonItem) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "favViewController") as! favViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    @IBOutlet weak var fav: UIBarButtonItem!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        cell.lbltask.text = selectedtaskArray[indexPath.row]
        cell.lblday.text = selectedDayArray[indexPath.row]
        let image = UIImage(named: "star.jpg")
        let image1 = UIImage(named: "bstar.jpg")
        if( selectedArray1[indexPath.row] == "true")
        {
            cell.btnimgage.setBackgroundImage(image, for: .normal)
        }
        else
        {
             cell.btnimgage.setBackgroundImage(image1, for: .normal)
        }
        
        return cell
    }
    
    var selectedtaskArray = [String]()
    var selectedDayArray = [String]()
    var selectedArray1 = [String]()
    @IBAction func nextview(_ sender: UIBarButtonItem)
    {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "nextViewController") as! nextViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectQuery =  "select * from tasktable"
        SQLDatabase.sharedObject.SelectAllTask(query: selectQuery)
        selectedArray1 = SQLDatabase.sharedObject.SelectedArray!
        selectedDayArray = SQLDatabase.sharedObject.DayArray!
        selectedtaskArray = SQLDatabase.sharedObject.TaskArray!
        if(selectedtaskArray.count > 0)
        {
            
            print(selectedArray1)
            print(selectedDayArray)
            print(selectedtaskArray)
        }
        tableview.reloadData()
        
    
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
      
        let str = selectedtaskArray[indexPath.row]
        
        let moreAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Update") { (action, indexPath)  in
            
            
            let alert = UIAlertController(title: "Update", message: "Update Task", preferredStyle: .alert)
            
          
            
            alert.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "Enter Task"
            })
            
            let saveaction = UIAlertAction(title: "Update", style: .default) { (action) in
                guard let textField = alert.textFields?.first
                    else
                {
                    return
                }
                if let textToEdit = textField.text{
                    if textToEdit.count == 0
                    {
                        return
                    }
                    //task.taskName = textToEdit
                    self.tableview.reloadRows(at: [indexPath], with: .automatic)
                    let updateQuery = "update tasktable set taskname = '\(textField.text!)'  where taskname = '\(str)'"
                    let isSuccess = SQLDatabase.sharedObject.executeQuery(query: updateQuery)
                    if isSuccess
                    {
                        print("successfully status change in database")
//                          cell.lbltask.text = textField.text
//                        self.tableview.reloadRows(at: [indexPath], with: .automatic)
                    }
                    else
                    {
                        print("updating Failed")
                    }
                    let selectQuery =  "select * from tasktable"
                    SQLDatabase.sharedObject.SelectAllTask(query: selectQuery)
                    self.selectedArray1 = SQLDatabase.sharedObject.SelectedArray!
                    self.selectedDayArray = SQLDatabase.sharedObject.DayArray!
                    self.selectedtaskArray = SQLDatabase.sharedObject.TaskArray!
                    if(self.selectedtaskArray.count > 0)
                    {
                        
                        print(self.selectedArray1)
                        print(self.selectedDayArray)
                        print(self.selectedtaskArray)
                    }
                    self.tableview.reloadData()
                    
                }else
                {
                    return
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            
            
           
            alert.addAction(saveaction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)

        }
        
        moreAction.backgroundColor = UIColor.brown
   
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" )  { (action, indexPath)  in
       
            let alert = UIAlertController(title: "Delete", message: "Delete Task", preferredStyle: .alert)
            
            let saveaction = UIAlertAction(title: "Delete", style: .default) { (action) in
                
                
                    //task.taskName = textToEdit
                    self.tableview.reloadRows(at: [indexPath], with: .automatic)
                    let updateQuery = "delete from tasktable where taskname = '\(str)'"
                    let isSuccess = SQLDatabase.sharedObject.executeQuery(query: updateQuery)
                    if isSuccess
                    {
                        print("successfully delete in database")
                        //                          cell.lbltask.text = textField.text
                        //                        self.tableview.reloadRows(at: [indexPath], with: .automatic)
                    }
                    else
                    {
                        print("updating Failed")
                    }
                    let selectQuery =  "select * from tasktable"
                    SQLDatabase.sharedObject.SelectAllTask(query: selectQuery)
                    self.selectedArray1 = SQLDatabase.sharedObject.SelectedArray!
                    self.selectedDayArray = SQLDatabase.sharedObject.DayArray!
                    self.selectedtaskArray = SQLDatabase.sharedObject.TaskArray!
                    if(self.selectedtaskArray.count > 0)
                    {
                        
                        print(self.selectedArray1)
                        print(self.selectedDayArray)
                        print(self.selectedtaskArray)
                    }
                    self.tableview.reloadData()
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            
            
            
            alert.addAction(saveaction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
            //
        }
        
        deleteAction.backgroundColor = UIColor.red
  return [deleteAction, moreAction]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

