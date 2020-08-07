////
////  Pin.swift
////  InvasaoAlienigena
////
////  Created by João Gabriel Araujo Jorge on 05/08/20.
////  Copyright © 2020 Juliana Prado. All rights reserved.
////
//
import Foundation

struct Cidade: Codable {
    let country: String?
    let name: String?
    let lat: String?
    let lng: String?
}

//class Pin {
//    var nome: String
//    var lat: Double
//    var lng: Double
//    let nomeImagem: String
//
//    init(cidade: Cidade) {
////        self.nome = cidade.name
////        self.lat = Double(cidade.lat)!
////        self.lng = Double(cidade.lng)!
////        self.nomeImagem = "skPin.png"
//
//    }
//}
//
//
//
//
//
//private func parse(jsonData: Data) {
//    do {
//        let decodedData = try JSONDecoder().decode(Cidade.self, from: jsonData)
//    } catch {
//        print("decode error")
//    }
//}
//
//private func loadJson(fromFileNamed: String, completion: @escaping (Result<Data, Error>) -> Void) {
//    if let url = URL(string: fromFileNamed) {
//        let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                completion(.failure(error))
//            }
//
//            if let data = data {
//                completion(.success(data))
//            }
//        }
//
//        urlSession.resume()
//    }
//}
