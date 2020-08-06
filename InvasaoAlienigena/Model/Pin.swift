//
//  Pin.swift
//  InvasaoAlienigena
//
//  Created by João Gabriel Araujo Jorge on 05/08/20.
//  Copyright © 2020 Juliana Prado. All rights reserved.
//

import Foundation

class Pin{
    var country: String
    var name: String
    var lat: Double
    var lng: Double
    let nomeImagem: String
    
    init(nomeCidade: String) {
        self.country = ""
        self.name = nomeCidade
        self.lat = 0.0
        self.lng = 0.0
        self.nomeImagem = "skPin.png"

    }
}
