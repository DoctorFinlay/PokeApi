//
//  MainVC.swift
//  AFPokeApi
//
//  Created by Iain Coleman on 19/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import UIKit


class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func browsePokemonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_BROWSE, sender: nil)
    }
    
    @IBAction func findPokemonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_FINDER, sender: nil)
    }
    
    
}
