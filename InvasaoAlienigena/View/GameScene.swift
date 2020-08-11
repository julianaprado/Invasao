//
//  GameScene.swift
//  InvasaoAlienigena
//
//  Created by Juliana Prado on 05/08/20.
//  Copyright © 2020 Juliana Prado. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene {

    func geraPins(cidades: [Cidade]) -> ([Pin]) {
        var pins: [Pin] = []
        for cidade in cidades {
            pins.append(Pin(cidade: cidade))
        }
        return pins
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .red
    }
    
    override func update(_ currentTime: TimeInterval) {
        geraPins(cidades: dao?.cidades ?? [])
        
    }
}
