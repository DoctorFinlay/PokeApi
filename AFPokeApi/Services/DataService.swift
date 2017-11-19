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
import AFNetworking

class DataService {
    
    static let instance = DataService()
    
    public private(set) var pokemonImageUrl = ""
    public private(set) var pokemonImageView = UIImageView()
    public let currentPokemon = Pokemon()
    
    enum pokemonApiParameterKeys: String {
        case id
        case weight
        case base_experience
        case types
        case name
        case type
        case url
    }
    
    
    func getPokeData(text: String, completion: @escaping CompletionHandler) {
        
        let url = "\(DATA_URL)\(text)/"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
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
            //Uses String extension to capitalise first letter of Pokemon
            var pokemonName = json["name"].stringValue.firstUppercased
            if pokemonName == "" {
                pokemonName = "Pokémon Not Found"
            }
            let pokemonId = json["id"].int
            let pokemonWeight = json["weight"].int
            let pokemonBaseExperience = json["base_experience"].int
            
            //Clear types from type array
            DataService.instance.currentPokemon.pokemonTypes.removeAll()
            //This gets an array of the values for "name", stored within "types" then "type"
            let typesArray = json["types"].arrayValue.map({$0["type"]["name"].stringValue})
            for item in typesArray {
                self.currentPokemon.pokemonTypes.append(item.firstUppercased)
                print("Added \(item)")
            }
 
            self.currentPokemon.pokemonName = pokemonName
            self.currentPokemon.pokemonId = pokemonId!
            self.currentPokemon.pokemonWeight = pokemonWeight!
            self.currentPokemon.pokemonBaseExperience = pokemonBaseExperience!
        } catch {
            print(error)
        }
    }
    
    
    
}
