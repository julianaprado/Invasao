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
    var pinsBrasil:[Cidade] = []
    var pinsItalia:[Cidade] = []
    var pinsUSA:[Cidade] = []
    
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
        tresCidades.append(italia.randomElement()!)
        tresCidades.append(usa.randomElement()!)
        
        for cidade in tresCidades {
            pinsBrasil.append(cidade)
            pinsItalia.append(cidade)
            pinsUSA.append(cidade)
        }
        
        var cidade = brasil.randomElement()!
        while (cidade.name == pinsBrasil[0].name) {
            cidade = brasil.randomElement()!
        }
        
        pinsBrasil.append(cidade)
        pinsItalia.append(cidade)
        
        while (cidade.name == pinsBrasil[0].name) || (cidade.name == pinsBrasil[3].name) {
            cidade = brasil.randomElement()!
        }
        
        pinsBrasil.append(cidade)
        pinsUSA.append(cidade)
        
        while (cidade.name == pinsBrasil[0].name) || (cidade.name == pinsBrasil[3].name) || (cidade.name == pinsBrasil[4].name) {
            cidade = brasil.randomElement()!
        }
        
        pinsItalia.append(cidade)
        pinsUSA.append(cidade)
        
        cidade = italia.randomElement()!
        while (cidade.name == pinsBrasil[1].name) {
            cidade = italia.randomElement()!
        }
        
        pinsBrasil.append(cidade)
        pinsItalia.append(cidade)
        
        while (cidade.name == pinsBrasil[1].name) || (cidade.name == pinsBrasil[5].name) {
            cidade = italia.randomElement()!
        }
        
        pinsBrasil.append(cidade)
        pinsUSA.append(cidade)
        
        while (cidade.name == pinsBrasil[1].name) || (cidade.name == pinsBrasil[5].name) || (cidade.name == pinsBrasil[6].name) {
            cidade = italia.randomElement()!
        }
        
        pinsItalia.append(cidade)
        pinsUSA.append(cidade)
        
        cidade = usa.randomElement()!
        while (cidade.name == pinsBrasil[2].name) {
            cidade = usa.randomElement()!
        }
        
        pinsBrasil.append(cidade)
        pinsItalia.append(cidade)
        
        while (cidade.name == pinsBrasil[2].name) || (cidade.name == pinsBrasil[7].name) {
            cidade = usa.randomElement()!
        }
        
        pinsBrasil.append(cidade)
        pinsUSA.append(cidade)
        
        while (cidade.name == pinsBrasil[2].name) || (cidade.name == pinsBrasil[7].name) || (cidade.name == pinsBrasil[8].name) {
            cidade = italia.randomElement()!
        }
        
        pinsItalia.append(cidade)
        pinsUSA.append(cidade)
        
        
        
        for cidade in pinsBrasil {
            print(cidade.name!)
        }
        
        for cidade in pinsItalia {
            print(cidade.name!)
        }
        
        for cidade in pinsUSA {
            print(cidade.name!)
        }
        
        return

    }
   
    func getURL(for name: String) -> URL?{
        return Bundle.main.url(forResource: name, withExtension: "json")
    }
    
}

