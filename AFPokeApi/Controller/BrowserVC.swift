//
//  BrowserVC.swift
//  AFPokeApi
//
//  Created by Iain Coleman on 19/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import UIKit

class BrowserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Check to see if data is already loaded, if not get data from server
        
        if DataService.instance.pokemonNamesArray.count == 150 {
            print("Data already loaded")
        } else {
            DataService.instance.get150PokemonData { (success) in
                if success {
                    self.tableView.reloadData()
                    print("Data retrieved from server")
                }
            }
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "browserCell", for: indexPath) as? BrowserTableViewCell {
            //Set pokemon name label
            let name = DataService.instance.pokemonNamesArray[indexPath.row]
            cell.configureCell(name: name)
            let pokemonNumber = indexPath.row + 1
            //Set alternate background colour
            if pokemonNumber % 2 == 1 {
                cell.backgroundColor = UIColor.lightGray
            } else {
                cell.backgroundColor = UIColor.white
            }
            //Set pokemon number label to be 3 digits with #
            if pokemonNumber < 10 {
                cell.numberLbl.text = "#00\(pokemonNumber)"
            } else if pokemonNumber < 100 {
                cell.numberLbl.text = "#0\(pokemonNumber)"
            } else {
                cell.numberLbl.text = "#\(pokemonNumber)"
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let toPass = String(indexPath.row + 1) //This will send the pokemon number as a string to the modal VC
        let pokemonViewer = BrowsePokemonModalVC()
        pokemonViewer.toPass = toPass
        pokemonViewer.modalPresentationStyle = .custom
        present(pokemonViewer, animated: true, completion: nil)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.pokemonNamesArray.count
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
