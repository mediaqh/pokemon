//
//  PokemonDetailVC.swift
//  Pokemon
//
//  Created by Tran Tuan on 10/22/17.
//  Copyright © 2017 Tran Tuan. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    @IBOutlet weak var pokemonNameLB: UILabel!
    @IBOutlet weak var typeLB: UILabel!
    @IBOutlet weak var defenceLB: UILabel!
    @IBOutlet weak var heighLB: UILabel!
   
    @IBOutlet weak var firstImg: UIImageView!
    @IBOutlet weak var secondPokemonImg: UIImageView!
    @IBOutlet weak var upgradeLB: UILabel!
    @IBOutlet weak var currentPokemonImg: UIImageView!
    @IBOutlet weak var descriptionLB: UILabel!
    @IBOutlet weak var attactLB: UILabel!
    @IBOutlet weak var weightLB: UILabel!
    @IBOutlet weak var idLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetUI()
        // Do any additional setup after loading the view.
        
        pokemon.dowloadDetail {
            self.updateUI()
        }
    }
    
    func updateUI(){
        pokemonNameLB.text = pokemon.name
        heighLB.text = pokemon.height
        weightLB.text = pokemon.weight
        defenceLB.text = pokemon.defence
        descriptionLB.text = pokemon.description
        typeLB.text = pokemon.type
        idLB.text = "\(pokemon.pokemonId)"
        
    }
    func resetUI() {
        pokemonNameLB.text = ""
        heighLB.text = ""
        weightLB.text = ""
        defenceLB.text = ""
        descriptionLB.text = ""
        idLB.text = ""
        typeLB.text = ""
        firstImg.image = UIImage(named: "\(pokemon.pokemonId)")
        currentPokemonImg.image = firstImg.image
        secondPokemonImg.image = UIImage(named: "\(pokemon.pokemonId + 1)")
    }
    
    @IBAction func backBtn_Pressed(_ sender: UIButton) {
        print("back")
        self.dismiss(animated: true, completion: nil)
    }
}
