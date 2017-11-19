//
//  Constants.swift
//  AFPokeApi
//
//  Created by Iain Coleman on 16/11/2017.
//  Copyright © 2017 Iain Coleman. All rights reserved.
//

import Foundation

//When we send a web request, we need to know if it completed or not - the completion handler is a closure that handles this
typealias CompletionHandler = (_ Success: Bool) -> ()


//URL Constants
let BASE_URL = "https://pokeapi.co/"
let DATA_URL = "\(BASE_URL)api/v2/pokemon/"  //This by itself lists all pokemon, including giving us a "count"
let IMAGE_URL = "\(BASE_URL)media/sprites/pokemon/"
