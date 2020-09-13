//
//  TableViewController.swift
//  ToDoList
//
//  Created by Игорь Козлов on 10.09.2020.
//  Copyright © 2020 Игорь Козлов. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
        
    
    @IBAction func editButtonAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)

    }
    
    //обработчик события нажатия на кнопку +
    @IBAction func addItem(_ sender: Any) {
        //Всплывающее окно для ввода текста UIAlertController
        //Контроллер
        
        let alertContoller = UIAlertController(title:"Create new Item", message: "", preferredStyle: /*тип всплывающего окна */.alert)
        
        //Добавляем текстовое поле
        alertContoller.addTextField { (textField) in
            textField.placeholder = "New item name"// плейсхолдер - еле видное сообщение в поле ввода перед вводом
        }
        
        //Создаём кнопки
        let alertAction1 = UIAlertAction(title: "Create", style: .cancel) { ( alert ) in
            //добавить новую запить
            let newItem = alertContoller.textFields![0].text//Получаем то, что было написано в поле текства, после нажатия create
            
            //добавление
            if newItem != "" {
                addNewItem(nameItem: newItem!)
                //for mirror in table
                self.tableView.reloadData()
            }
        }
        
        let alertAction2 = UIAlertAction(title: "Cancel", style: .destructive) { ( alert ) in
            //Ничего не делаем при нажатии кнопки
        }
        //
        
        
        //добавляем алерт контроллеру алертАкшнs(кнопку
        alertContoller.addAction(alertAction1)
        alertContoller.addAction(alertAction2)
        
        //функция для всплывания окна
        present(alertContoller, animated: true) {
            //Код выполняющийся, когда контроллер появится на экране
            //Ничего не будет делать
        }
        
    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoItems.count
    }

    
    //Метод-делегат для отображения конфигурации строк
    //вызывается при вызове reloadData() Для каждой строки indexPath.row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = toDoItems[indexPath.row]["Name"] as? String//присваеваем текст из массива данных
        
        
        //Set checkMark isComplited
        //Проверка выполнено действие или нет
        if (toDoItems[indexPath.row]["isComplited"] as? Bool) == true {
            //Comlite
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    

    //Можео ли редактировать таблицу
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    // удаление ячейки
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {//стиль удаления ячейки при слайде
            
            // Delete the row from the data source
            removeItem(at: indexPath.row)//Удаляем ячейку
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        } else if editingStyle == .insert {//стиль вставки ячейки
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    //обработка нажатия на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }


    //Смена записей местами в таблице, если она находится в режиме редактирования
    //Ввести в режим редактирования можно методом tableView.setEditing()
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveCells(from: fromIndexPath.row, to: to.row)
        tableView.reloadData()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
