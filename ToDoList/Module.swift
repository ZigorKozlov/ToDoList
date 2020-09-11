//
//  Module.swift
//  ToDoList
//
//  Created by Игорь Козлов on 10.09.2020.
//  Copyright © 2020 Игорь Козлов. All rights reserved.
//

import Foundation

var toDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoListApp1_IgorKozlov")
        UserDefaults.standard.synchronize()
    }
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoListApp1_IgorKozlov") as? [[String: Any]] {
            return array
        } else {
            return []
        }
    }
}

func moveCells(from: Int, to: Int){
    let temp = toDoItems[from]
    toDoItems.remove(at: from)
    toDoItems.insert(temp, at: to)
}

func addNewItem(nameItem: String, isComplited: Bool = false) -> Void {
    toDoItems.append(["Name": nameItem, "isComplited": isComplited])
}

func removeItem(at index: Int) {
    toDoItems.remove(at: index)
}

func changeState(at item: Int)-> Bool {
    toDoItems[item]["isComplited"] = !(toDoItems[item]["isComplited"] as! Bool)
   
    return  toDoItems[item]["isComplited"] as! Bool
}
