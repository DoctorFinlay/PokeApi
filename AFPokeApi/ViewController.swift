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
        
    }
  
    func textFieldDidBeginEditing(_ textField: UITextField) {
        goButton.isEnabled = true
    }
    

    @IBAction func goButtonPressed(_ sender: Any) {
        if pokeNoTxtField.text != nil {
            let text = pokeNoTxtField.text!
            self.spinner.isHidden = false
            self.spinner.startAnimating()
            DataService.instance.getPokeData(text: pokeNoTxtField.text!, completion: { (success) in
                if success {
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                    self.populateOutlets(name: DataService.instance.pokemonName)
                    let url = URL(string: "\(IMAGE_URL)\(text).png")!
                    print(url)
                    self.image.kf.setImage(with: url)
                }
            })
        }
    }
    
    func populateOutlets(name: String) {
        pokemonNameLbl.text = name
        
        
    }
  
    
    
}

