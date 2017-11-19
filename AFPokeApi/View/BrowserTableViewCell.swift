//
//  BrowserTableViewCell.swift
//  AFPokeApi
//
//  Created by Iain Coleman on 19/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import UIKit
import Kingfisher

class BrowserTableViewCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var pokemonLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configureCell(name: String) {
        self.pokemonLbl.text = name.firstUppercased
    }
}
