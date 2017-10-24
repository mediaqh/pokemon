//
//  PokeCell.swift
//  Pokemon
//
//  Created by Tran Tuan on 10/16/17.
//  Copyright © 2017 Tran Tuan. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    
    var pokemon: Pokemon!
    
    func configure(_ pokemon: Pokemon){
        self.pokemon = pokemon
        thumbImg.image = UIImage(named: "\(pokemon.pokemonId)")
        nameLb.text = pokemon.name
    }
}
