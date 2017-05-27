//
//  AddTaskViewController.swift
//  toDoList
//
//  Created by Rodrigo Guerra Castilla on 23/05/17.
//  Copyright © 2017 Rodrigo Guerra Castilla. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
     
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }


    @IBAction func btnTapped(_ sender: Any) {
        
        var nombreLibro = ""
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        
        
       let numISBN = self.textField.text!//"978-84-376-0494-7"
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(numISBN)"
        let url = NSURL(string: urls)
        let datos:NSData? = NSData(contentsOf: url! as URL)
        
        
            do{
                let json = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                let dico1 = json as! NSDictionary
                let dico2 = dico1["ISBN:\(numISBN)"] as! NSDictionary
                let titulo = dico2["title"] as! NSString as String
                nombreLibro = titulo
               
            }
            catch _ {
                
        }

        
    
        task.name = nombreLibro//textField.text!
        
             
        task.isbn = textField.text!
        
        
        
        
        
        
        //Save the data to caroData
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //navigationController!.popViewController(animated: true)
    
        
    }
    
     @IBAction func textFieldDoneEditing(sender:UITextField){
    sender.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cc = segue.destination as! LibroViewController
        
       // let ip = self.tableView.indexPathForSelectedRow //este es la nformacion del renglon seleccionado
        cc.codigo = textField.text!//self.ciudades[ip!.row][1]
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
