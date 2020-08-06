//
//  Pin.swift
//  InvasaoAlienigena
//
//  Created by João Gabriel Araujo Jorge on 05/08/20.
//  Copyright © 2020 Juliana Prado. All rights reserved.
//

import Foundation

class Pin{
    var nomeCidade: String
    let nomeImagem: String
    var latitude: Double
    var longitude: Double
    
    init(nomeCidade: String) {
        self.nomeCidade = nomeCidade
        self.nomeImagem = "skPin.png"
        self.latitude = 0.0
        self.longitude = 0.0
    }
}
