//
//  SQLDatabase.swift
//  swarajya.todo<swapnil>
//
//  Created by Mac on 01/02/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import SQLite3

class SQLDatabase: NSObject {
    var db : OpaquePointer?
    var statement : OpaquePointer?
    var TaskArray : [String]?
    var DayArray : [String]?
    var SelectedArray: [String]?
    
    
    static let sharedObject = SQLDatabase()
    func gateDatabasePath() -> String
    {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = docDir.first!
        return path + "/swarajyaIT.sqlite"
    }
    
    func executeQuery(query: String) -> Bool
    {
        var success = false
        let dbpath = gateDatabasePath()
        if(sqlite3_open(dbpath, &db) == SQLITE_OK)
        {
            if (sqlite3_prepare(db, query, -1, &statement, nil) == SQLITE_OK)
            {
                if(sqlite3_step(statement) == SQLITE_DONE)
                {
                    success = true
                    sqlite3_finalize(statement!)
                    sqlite3_close(db!)
                }
                else
                {
                    print("Error in executing statement\(sqlite3_errmsg(db!))")
                }
            }
            else
            {
                print("Error in preparing\(sqlite3_errmsg(db!))")
            }
        }
        else
        {
            print("Error in openingdatabase\(sqlite3_errmsg(db!))")
        }
        return success
    }
    
    func SelectAllTask(query: String)
    {
        TaskArray = [String]()
        SelectedArray = [String]()
        DayArray = [String]()
        
        let dbPath = gateDatabasePath()
        if(sqlite3_open(dbPath, &db) == SQLITE_OK)
        {
            if (sqlite3_prepare(db, query, -1, &statement, nil) == SQLITE_OK)
            {
                while(sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    let tasknameInc = sqlite3_column_text(statement, 0)
                    let taskname = String(cString: tasknameInc!)
                    let dayInc = sqlite3_column_text(statement, 1)
                    let dayname = String(cString: dayInc!)
                    let selectednameInc = sqlite3_column_text(statement, 2)
                    let selectedname = String(cString: selectednameInc!)
                   
                    
                    TaskArray!.append(taskname)
                    DayArray!.append(dayname)
                    SelectedArray!.append(selectedname)
                    
                }
                sqlite3_close(db!)
            }
                
            else
            {
                print("Error in preparing statement \(sqlite3_errmsg(db!))")
            }
        }
        else
        {
            print("Error opening database\(sqlite3_errmsg(db!))")
        }
    }
    
    func createTable()
    {
        let createQuery = "create table if not exists tasktable(taskname text,dayname text,status text)"
        let isSuccess = executeQuery(query: createQuery)
        if isSuccess
        {
            print("Database Successfully Created")
        }
        else
        {
            print("Database  Creation Failed")
        }
    }
    

}
