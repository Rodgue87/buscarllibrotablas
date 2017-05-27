//
//  ViewController.swift
//  toDoList
//
//  Created by Rodrigo Guerra Castilla on 22/05/17.
//  Copyright © 2017 Rodrigo Guerra Castilla. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks : [Task] = []
    
    var numeroIsbn = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
        //borrar?
        
        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)//#selector(insertNewObject(_:)))
        //self.navigationItem.rightBarButtonItem = addButton
        
        
        }
    
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        //get data from coredata
        getData()
        //reload the table view
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath)
        let task = tasks[indexPath.row]
        
        //if task.isImportant {
          //  cell.textLabel?.text = "😀 \(task.name!)"
        //} else{
        
        
        cell.textLabel?.text = task.name!
        //}
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detallesLibro"){
        let cc = segue.destination as! LibroViewController
      
        let ip = self.tableView.indexPathForSelectedRow //este es la nformacion del renglon seleccionado
        
        let codigoDos = tasks[ip!.row]
        
        cc.codigo = codigoDos.isbn!
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
        tasks = try context.fetch(Task.fetchRequest())
        }catch{
            print("Fetching Failed")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                tasks = try context.fetch(Task.fetchRequest())
                
            }catch{
                print("Fetching Failed")
            }
            tableView.reloadData()
        }
    }
    
   
    


}

