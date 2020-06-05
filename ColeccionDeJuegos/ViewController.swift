//
//  ViewController.swift
//  ColeccionDeJuegos
//
//  Created by mbtec22 on 5/28/20.
//  Copyright © 2020 dquispe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var juegos : [Juego] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var imagePicker = UIImagePickerController()
    
    var juego : Juego? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate =  self
    }
    override func viewWillAppear(_ animated: Bool){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try juegos = context.fetch(Juego.fetchRequest())
            tableView.reloadData()
        } catch {
            
        }
            
    }
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int{
        return juegos.count
    }
    func tableView(_ tableView:UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        let juego = juegos[indexPath.row]
        cell.textLabel?.text = juego.titulo
        cell.imageView?.image = UIImage(data: (juego.imagen!) as Data)
        return cell
    }
    func tableView(_ tableView:UITableView,didSelectRowAt indexPath: IndexPath){
        let juego = juegos[indexPath.row]
        performSegue(withIdentifier:"juegoSegue",sender: juego)
        
    }
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
        let siguienteVc = segue.destination as! JuegoViewController
        siguienteVc.juego = sender as? Juego
    }
    
}

