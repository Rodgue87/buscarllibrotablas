//
//  LibroViewController.swift
//  toDoList
//
//  Created by Rodrigo Guerra Castilla on 26/05/17.
//  Copyright © 2017 Rodrigo Guerra Castilla. All rights reserved.
//

import UIKit

class LibroViewController: UIViewController {
    
    var codigo = ""
    
    @IBOutlet weak var informacionLibro: UITextView!
    
    @IBOutlet weak var cover: UIImageView!
    
    var portada:String?
    
    var portadaURL:URL?
    
    var imagenPortada = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //"978-84-376-0494-7"
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(codigo)"
        let url = NSURL(string: urls)
        let datos:NSData? = NSData(contentsOf: url! as URL)
        
        if (datos == nil) {
            
            informacionLibro.text = "No hay conexión a Internet"
            showAlertMessage(title: "Error", message: "No hay conexión a Internet", owner: self)
            
        } else {
            
            do{
                let json = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                let dico1 = json as! NSDictionary
                let dico2 = dico1["ISBN:\(codigo)"] as! NSDictionary
                //self.informacion.text = dico2["title"] as! NSString as String!
                let dico3 = dico2["authors"] as! NSArray as Array
                //let i = 0
                for i in 0 ..< dico3.count{
                    let autores = dico3[i]["name"] as! NSString as String
                    self.informacionLibro.text = (String: "Titulo del libro" + "\n" + "\n" + ((dico2["title"] as! NSString) as String) + "\n" + "\n" + "Autor(es)" + "\n" +  "\n" + autores + imagenPortada)
                }
                if dico2["cover"] == nil{
                    imagenPortada = ""
                } else {
                    let dico4 = dico2["cover"] as! NSDictionary as NSDictionary
                    let portadaGrande: String? = dico4["large"] as? String
                    if portadaGrande != nil {
                        //portada = ""
                        portadaURL = URL(string: portadaGrande!)
                        
                        let task = URLSession.shared.dataTask(with: portadaURL!){responseData,response,error in if error == nil{
                            if let data = responseData {
                                
                                DispatchQueue.main.async {
                                    self.cover.image = UIImage(data: data)
                                }
                                
                            }else {
                                print("no data")
                            }
                        }else{
                            print("error")
                            }
                        }
                        task.resume()
                        
                    }else {
                        portada = "No hay portada"
                    }
                    imagenPortada = ""
                }
            }
            catch _ {
                
            }
            
            
            
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func volver(_ sender: Any) {
        
        navigationController!.popToRootViewController(animated: true)//popViewController(animated: true)
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
    func showAlertMessage (title: String, message: String, owner:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler:{ (ACTION :UIAlertAction!)in
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
