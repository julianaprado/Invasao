//
//  Player.swift
//  InvasaoAlienigena
//
//  Created by Juliana Prado on 05/08/20.
//  Copyright © 2020 Juliana Prado. All rights reserved.
//

import Foundation

struct Player:Codable{
    
    var nomePais : String
    
    
    init(pais: String) {
        nomePais = pais
    }
}
