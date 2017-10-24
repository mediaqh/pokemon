//
//  ViewController.swift
//  Pokemon
//
//  Created by Tran Tuan on 10/16/17.
//  Copyright © 2017 Tran Tuan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

    @IBOutlet weak var pokemonCL: UICollectionView!
    private var pokemon = [Pokemon]()
    private var player: AVAudioPlayer!
    
    private var filterPokemon: [Pokemon]!

    @IBOutlet weak var pokemonSB: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pokemonSB.delegate = self
        pokemonSB.returnKeyType = UIReturnKeyType.done
        
        pokemonCL.dataSource = self
        pokemonCL.delegate = self
        getDataFromCSV()
        
        searchBar(pokemonSB,textDidChange: "")
        
        initSound()
    }
    
    func initSound() {
        let urlSound = Bundle.main.url(forResource: "music", withExtension: "mp3")!
        do {
            player = try AVAudioPlayer(contentsOf: urlSound)
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func getDataFromCSV() {
        let fileUrl = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: fileUrl)
            let rows = csv.rows
      
            for row in rows{
                let id = Int(row["id"]!)!
                let name = row["identifier"]!
                pokemon.append(Pokemon(name: name, id: id))
            }
        
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke = filterPokemon[indexPath.row]
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return filterPokemon.count

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            cell.configure(filterPokemon[indexPath.row])
            return cell
        }else
        {
            return UICollectionViewCell()
        }
    }

    @IBAction func imgBtn_preesed(_ sender: UIButton) {
        if(player.isPlaying){
            sender.alpha = 0.3
            player.pause()
        }else{
            sender.alpha = 1
            player.play()       }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange")
        if searchText != ""{
            filterPokemon = pokemon.filter({$0.name.range(of: searchText.lowercased()) != nil})
        }else{
            filterPokemon = pokemon
            view.endEditing(true)
        }
        pokemonCL.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: Navigate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC"{
            if let destination = segue.destination as? PokemonDetailVC{
                if let poke = sender as? Pokemon{
                    destination.pokemon = poke
                }
            }
        }
    }
}

