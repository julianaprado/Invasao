//
//  DAO.swift
//  InvasaoAlienigena
//
//  Created by Juliana Prado on 06/08/20.
//  Copyright © 2020 Juliana Prado. All rights reserved.
//

import Foundation


var dao = DAO()
//let data: Data // received from a network request, for example
//let json = try? JSONSerialization.jsonObject(with: data, options: [])

class DAO {
    
    var players:[Player] = []
    var playerOne:Player
    var pins:[Cidade] = []
    
    
    fileprivate init?(){
        self.playerOne = Player(pais: "brasil")
        self.players.append(playerOne)
        let localFile = getURL(for: "cities")
        print(localFile)
        try? self.pins.load(from: localFile!)
        
        print(pins.count)
        
    }
    
    func getURL(for name: String) -> URL?{
        return Bundle.main.url(forResource: name, withExtension: "json")
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }

        return nil
    }
    
}

