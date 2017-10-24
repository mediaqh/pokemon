//
//  Pokemon.swift
//  Pokemon
//
//  Created by Tran Tuan on 10/16/17.
//  Copyright © 2017 Tran Tuan. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokemonID: Int!
    private var _type: String!
    private var _defence: String!
    private var _weight: String!
    private var _height: String!
    private var _attack: String!
    private var _description: String!
    
    var name: String{
        if _name == nil{
            _name = ""
        }
        return _name
    }
    var type: String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    var defence: String{
        if _defence == nil{
            _defence = ""
        }
        return _defence
    }
    var weight: String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    var height: String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    var attack: String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    var description: String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    var pokemonId: Int{
        if _pokemonID == nil{
            _pokemonID = 0
        }
        return _pokemonID
    }
    
    init(name: String, id: Int) {
        _name = name
        _pokemonID = id
    }
    
    func dowloadDetail(completed: @escaping DownloadCompleted){
        let urlPoke = "\(URL_BASE)\(URL_POKEMON)\(self.pokemonId)/"
        Alamofire.request(urlPoke).responseJSON { reponse in
            if let dict = reponse.result.value as? Dictionary<String, AnyObject>{

                if let weight = dict["weight"] as? Int{
                    self._weight = "\(weight)"
                }
                if let height = dict["height"] as? Int{
                    self._height = "\(height)"
                }
                if let types = dict["types"] as? [Dictionary<String,AnyObject>] , types.count > 0 {
                    if let type = types[0]["type"] as? Dictionary<String,AnyObject>{
                        if let content = type["name"] as? String{
                              self._type = content.capitalized
                        }
                    }

                    for x in 1..<types.count{
                        if let type = types[x]["type"] as? Dictionary<String,AnyObject>{
                            if let content = type["name"] as? String{
                                self._type! += "/\(content.capitalized)"

                            }
                        }
                    }
                }
            }
            completed()
        }
    }
}
