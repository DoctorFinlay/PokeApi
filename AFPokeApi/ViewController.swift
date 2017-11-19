//
//  ViewController.swift
//  AFPokeApi
//
//  Created by Iain Coleman on 16/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import UIKit
import AFNetworking
import Kingfisher

class ViewController: UIViewController, UITextFieldDelegate {

    //Outlets
    @IBOutlet weak var pokeNoTxtField: UITextField!
    @IBOutlet weak var pokemonNameLbl: UILabel!
    @IBOutlet weak var pokemonIdLbl: UILabel!
    @IBOutlet weak var pokemonWeightLbl: UILabel!
    @IBOutlet weak var pokemonBaseExpLbl: UILabel!
    @IBOutlet weak var pokemonAbilitiesLbl: UILabel!
    @IBOutlet weak var pokemonTypesLbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeNoTxtField.delegate = self
        
        setupView()
    
    }
    
    func setupView() {
        spinner.isHidden = true
        goButton.isEnabled = false
        image.image = UIImage(named: "empty")
        pokemonNameLbl.isHidden = true
        pokemonIdLbl.isHidden = true
        pokemonWeightLbl.isHidden = true
        pokemonBaseExpLbl.isHidden = true
        pokemonAbilitiesLbl.isHidden = true
        pokemonTypesLbl.isHidden = true
        
    }
  
    func textFieldDidBeginEditing(_ textField: UITextField) {
        goButton.isEnabled = true
        image.isHidden = true
        pokemonNameLbl.isHidden = true
        pokemonIdLbl.isHidden = true
        pokemonWeightLbl.isHidden = true
        pokemonBaseExpLbl.isHidden = true
        pokemonAbilitiesLbl.isHidden = true
        pokemonTypesLbl.isHidden = true
    }
    

    @IBAction func goButtonPressed(_ sender: Any) {
        var pokeNumber = 0
        if let checkNumber = pokeNoTxtField.text {
            pokeNumber = Int(checkNumber)!
        }
        
        if pokeNumber > 0  {
            let text = pokeNoTxtField.text!
            self.spinner.isHidden = false
            self.spinner.startAnimating()
            self.pokeNoTxtField.resignFirstResponder()
            DataService.instance.getPokeData(text: pokeNoTxtField.text!, completion: { (success) in
                if success {
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                    self.populateOutlets()
                    let url = URL(string: "\(IMAGE_URL)\(text).png")!
                    print(url)
                    self.image.kf.setImage(with: url)
                }
            })
        }
    }
    
    func populateOutlets() {
        pokemonNameLbl.text = DataService.instance.currentPokemon.pokemonName
        var pokedexIdAsThreeDigitString = ""
        if DataService.instance.currentPokemon.pokemonId < 10 {
            pokedexIdAsThreeDigitString = "00\(DataService.instance.currentPokemon.pokemonId)"
        } else if DataService.instance.currentPokemon.pokemonId < 100 {
            pokedexIdAsThreeDigitString = "0\(DataService.instance.currentPokemon.pokemonId)"
        } else {
            pokedexIdAsThreeDigitString = String(DataService.instance.currentPokemon.pokemonId)
        }
        pokemonIdLbl.text = "Pokédex ID: #\(pokedexIdAsThreeDigitString)"
        pokemonWeightLbl.text = "Weight: \(DataService.instance.currentPokemon.pokemonWeight)kg"
        pokemonBaseExpLbl.text = "Base Experience: \(DataService.instance.currentPokemon.pokemonBaseExperience)"
        var abilitiesJoined = ""
        abilitiesJoined = DataService.instance.currentPokemon.pokemonAbilities.joined(separator: ", ")
        if DataService.instance.currentPokemon.pokemonAbilities.count > 1 {
        pokemonAbilitiesLbl.text = "Abilities: \(abilitiesJoined)"
        } else {
            pokemonAbilitiesLbl.text = "Ability: \(abilitiesJoined)"
        }
        var typesJoined = ""
        typesJoined = DataService.instance.currentPokemon.pokemonTypes.joined(separator: ", ")
        if DataService.instance.currentPokemon.pokemonTypes.count > 1 {
            pokemonTypesLbl.text = "Types: \(typesJoined)"
        } else {
            pokemonTypesLbl.text = "Type: \(typesJoined)"
        }
        pokemonNameLbl.isHidden = false
        pokemonIdLbl.isHidden = false
        pokemonWeightLbl.isHidden = false
        pokemonBaseExpLbl.isHidden = false
        pokemonAbilitiesLbl.isHidden = false
        pokemonTypesLbl.isHidden = false
        image.isHidden = false
    }
  
    
    
}

