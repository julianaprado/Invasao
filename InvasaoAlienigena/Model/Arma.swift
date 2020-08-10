//
//  Arma.swift
//  InvasaoAlienigena
//
//  Created by João Gabriel Araujo Jorge on 10/08/20.
//  Copyright © 2020 Juliana Prado. All rights reserved.
//

import Foundation

class Arma {
    let player:Player
    var carga:Int
    
    init(player: Player) {
        self.player = player
        self.carga = 0
    }
}

class SuperArma {
    
    var armas:[Arma]
    var pronta:Bool
    
    func armaPronta() {
        for arma in armas {
            if (arma.carga < 10) {
                return
            }
        }
        self.pronta = true
        return
    }
    
    init() {
        self.armas = []
        self.pronta = false
    }
}
