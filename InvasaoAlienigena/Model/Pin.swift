////
////  Pin.swift
////  InvasaoAlienigena
////
////  Created by João Gabriel Araujo Jorge on 05/08/20.
////  Copyright © 2020 Juliana Prado. All rights reserved.
////
//
import Foundation
import UIKit


class Pin {
    var lat: Double
    var lng: Double
    var label: UILabel
    var imagem: UIImage?

    init(cidade: Cidade) {
        self.lat = Double(cidade.lat!)!
        self.lng = Double(cidade.lng!)!
        self.label = UILabel(frame: CGRect(origin: CGPoint(x: lat, y: lng), size: CGSize(width: 10, height: 10)))
        self.label.text = cidade.name
        self.imagem = UIImage(contentsOfFile: "skPin.png")

    }
}

