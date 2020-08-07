//
//  DAO.swift
//  InvasaoAlienigena
//
//  Created by Juliana Prado on 06/08/20.
//  Copyright © 2020 Juliana Prado. All rights reserved.
//

import Foundation


var dao = DAO()

class DAO {
    
    var players:[Player] = []
    var playerOne:Player
    var cidades:[Cidade] = []
    var italia:[Cidade] = []
    var brasil:[Cidade] = []
    var usa:[Cidade] = []
    var tresCidades:[Cidade] = []
    
    
    fileprivate init?(){
        self.playerOne = Player(pais: "brasil")
        self.players.append(playerOne)
        let localFile = getURL(for: "cities")
        try? self.cidades.load(from: localFile!)
        prepararVetores()
    
        
    }
    
    
    func prepararVetores(){
        for cidade in cidades{
            if cidade.country == "IT"{
                italia.append(cidade)
            } else if cidade.country == "US"{
                usa.append(cidade)
            } else if cidade.country == "BR"{
                brasil.append(cidade)
            }
        }
        
        tresCidades.append(brasil.randomElement()!)
        tresCidades.append(usa.randomElement()!)
        tresCidades.append(italia.randomElement()!)
            
        }
        
    
    func getURL(for name: String) -> URL?{
        return Bundle.main.url(forResource: name, withExtension: "json")
    }
    
}

