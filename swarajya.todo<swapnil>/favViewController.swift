//
//  favViewController.swift
//  swarajya.todo<swapnil>
//
//  Created by Mac on 02/02/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class favViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedtaskArray.count
    }
    
    @IBOutlet weak var tableview: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1") as! TableViewCell1
        cell1.lbltask.text = selectedtaskArray[indexPath.row]
        cell1.lblday.text = selectedDayArray[indexPath.row]
        let image = UIImage(named: "star")
       
        if( selectedArray1[indexPath.row] == "true")
        {
            cell1.btnimg.setBackgroundImage(image, for: .normal)
        }
     
        return cell1
    }
    
    var selectedtaskArray = [String]()
    var selectedDayArray = [String]()
    var selectedArray1 = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectQuery =  "select * from tasktable where status = 'true'"
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            selectedtaskArray.remove(at: indexPath.row)
            tableview.reloadData()
        }
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
