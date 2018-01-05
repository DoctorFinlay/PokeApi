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
    public private(set) var pokemonNamesArray = [String]()
    
    var justNamesArray = [String]()
    
    enum pokemonApiParameterKeys: String {
        case id
        case weight
        case base_experience
        case types
        case name
        case type
        case url
        case abilities
        case ability
        case results
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
            var pokemonName = json[pokemonApiParameterKeys.name.rawValue].stringValue.firstUppercased
            if pokemonName == "" {
                pokemonName = "Pokémon Not Found"
            }
            let pokemonId = json[pokemonApiParameterKeys.id.rawValue].int
            let pokemonWeight = json[pokemonApiParameterKeys.weight.rawValue].int
            let pokemonBaseExperience = json[pokemonApiParameterKeys.base_experience.rawValue].int
            
            //Clear types and abilities from instance arrays
            DataService.instance.currentPokemon.pokemonTypes.removeAll()
            DataService.instance.currentPokemon.pokemonAbilities.removeAll()
            //Get an array of the values for "name", stored within "types" then "type"
            
            let typesArray = json[pokemonApiParameterKeys.types.rawValue].arrayValue.map {$0[pokemonApiParameterKeys.type.rawValue][pokemonApiParameterKeys.name.rawValue].stringValue}
            //     The above can be written as below - the below line doesn't use the enum with the api parameter keys so not best practice
            //            let typesArray = json["types"].arrayValue.map({$0["type"]["name"].stringValue})
            for item in typesArray {
                self.currentPokemon.pokemonTypes.append(item.firstUppercased)
            }
            
            //Doing the same thing, this time for abilities which is nested in the same way
            let abilitiesArray = json[pokemonApiParameterKeys.abilities.rawValue].arrayValue.map{$0[pokemonApiParameterKeys.ability.rawValue][pokemonApiParameterKeys.name.rawValue].stringValue}
            for ability in abilitiesArray {
                self.currentPokemon.pokemonAbilities.append(ability.firstUppercased)
            }
            
            self.currentPokemon.pokemonName = pokemonName
            self.currentPokemon.pokemonId = pokemonId!
            self.currentPokemon.pokemonWeight = pokemonWeight!
            self.currentPokemon.pokemonBaseExperience = pokemonBaseExperience!
        } catch {
            print(error)
        }
    }
    
    func get150PokemonData(completion: @escaping CompletionHandler) {
        
        let url = POKEMON_150_LIST
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.set150PokemonAsArray(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    func set150PokemonAsArray(data: Data) {
        do {
            let json = try JSON(data: data)
            let namesArray = json[pokemonApiParameterKeys.results.rawValue].arrayValue.map{$0[pokemonApiParameterKeys.name.rawValue].stringValue}
       
            for name in namesArray {
              self.pokemonNamesArray.append(name)
            }
            
            print("Pokemon Names array contains \(pokemonNamesArray.count) items")
            
        } catch {
            print(error)
        }
        
        
        
        
    }
}
