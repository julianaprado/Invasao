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
    var pins:[Pin] = []
    
    fileprivate init(){
        self.playerOne = Player(pais: "brasil")
        self.players.append(playerOne)
        
        
        
    }
}

