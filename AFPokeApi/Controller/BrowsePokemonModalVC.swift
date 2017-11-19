//
//  BrowsePokemonModalVC.swift
//  AFPokeApi
//
//  Created by Iain Coleman on 19/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import UIKit
import Kingfisher

class BrowsePokemonModalVC: UIViewController {

    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var pokemonNameLbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var pokemonIdLbl: UILabel!
    @IBOutlet weak var pokemonWeightLbl: UILabel!
    @IBOutlet weak var pokemonBaseExpLbl: UILabel!
    @IBOutlet weak var pokemonAbilitiesLbl: UILabel!
    @IBOutlet weak var pokemonTypeLbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Variables
    var toPass = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        DataService.instance.getPokeData(text: toPass, completion:  { (success) in
            if success {
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                self.populateOutlets()
                let url = URL(string: "\(IMAGE_URL)\(self.toPass).png")!
                print(url)
                self.image.kf.setImage(with: url)
                self.pokemonIdLbl.isHidden = false
                self.image.isHidden = false
                self.pokemonNameLbl.isHidden = false
                self.pokemonWeightLbl.isHidden = false
                self.pokemonBaseExpLbl.isHidden = false
                self.pokemonAbilitiesLbl.isHidden = false
                self.pokemonTypeLbl.isHidden = false
            }
        })
    }


    func setupView() {
        spinner.isHidden = false
        spinner.startAnimating()
        pokemonNameLbl.isHidden = true
        pokemonIdLbl.isHidden = true
        image.isHidden = true
        pokemonIdLbl.isHidden = true
        pokemonWeightLbl.isHidden = true
        pokemonBaseExpLbl.isHidden = true
        pokemonAbilitiesLbl.isHidden = true
        pokemonTypeLbl.isHidden = true
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(BrowsePokemonModalVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
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
        pokemonIdLbl.text = "#\(pokedexIdAsThreeDigitString)"
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
            pokemonTypeLbl.text = "Types: \(typesJoined)"
        } else {
            pokemonTypeLbl.text = "Type: \(typesJoined)"
        }
    }
    
    
    @objc func closeTap(_ recogniser: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
