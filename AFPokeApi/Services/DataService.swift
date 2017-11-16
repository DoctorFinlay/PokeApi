//
//  DataService.swift
//  AFPokeApi
//
//  Created by Iain Coleman on 16/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher
import SwiftyJSON

class DataService {
    
    static let instance = DataService()
    
    public private(set) var pokemonName = ""
    public private(set) var pokemonImageUrl = ""
    public private(set) var pokemonImageView = UIImageView()

    
    let defaults = UserDefaults.standard
    
    func getPokeData(text: String, completion: @escaping CompletionHandler) {
        
        let url = "\(DATA_URL)\(text)/"
        print(url)
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                print("I ran")
                self.setPokemonData(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
       
    }
    
 
    
    
    func setPokemonData(data: Data)  {
        do {
            let json = try JSON(data: data)
            pokemonName = json["name"].stringValue
            
            if pokemonName == "" {
                pokemonName = "Pokémon Not Found"
            }
            
        } catch {
            print(error)
        }
        
        
    }
    
    
    
}
