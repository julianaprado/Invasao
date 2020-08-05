//
//  CodableExtension.swift
//  JsonClassSaver
//
//  Created by Ricardo Venieris on 30/11/18.
//  Copyright © 2018 LES.PUC-RIO. All rights reserved.
//

import Foundation

enum FileManageError:Error {
    case canNotSaveInFile
    case canNotReadFile
    case canNotConvertData
    case canNotDecodeData
}

extension Error {
    public var asString:String {
        return String(describing: self)
    }
}

extension Encodable {
    
    var asString:String? {
        return self.jsonData?.asString
    }
    
    var asDictionary:[String: Any]? {
        if let json:Data = self.jsonData
        {
            do {
                //                let jsonObject = try JSONSerialization.jsonObject(with: json, options: [])
                let jsonObject = try JSONSerialization.jsonObject(with: json, options: [JSONSerialization.ReadingOptions.allowFragments])
                
                // if jsonObject is OK
                if let dic = jsonObject as? [String: Any] {
                    return dic
                }
                // else
                if let value = jsonObject as? [Any] {
                    let key = String(describing: type(of:self))
                    return [key:value]
                }
            } catch {
                debugPrint(error.localizedDescription)
                return nil
            }
        } // else
        return nil
    }
    
    var asArray:[Any]? {
        do {
            return try JSONSerialization.jsonObject(with: JSONEncoder().encode(self), options: []) as? [Any]
        } catch {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
    var jsonData:Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {}
        return nil
    }
    
    func save(in file:String? = nil) throws {
        
        // generates URL for documentDir/file.json
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let fileName = file ?? String(describing: type(of: self))
        let url = URL(fileURLWithPath: documentDir.appendingPathComponent(fileName+".json"))
        
        // Try to save
        do {
            try JSONEncoder().encode(self).write(to: url)
            debugPrint("Save in", String(describing: url))
        } catch {
            debugPrint("Can not save in", String(describing: url))
            throw FileManageError.canNotSaveInFile
        }
        
    }
}

extension Decodable {
    mutating func load(from file:String? = nil) throws {
        
        // generates URL for documentDir/file.json
        let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let fileName = file ?? String(describing: type(of: self))
        let url = URL(fileURLWithPath: documentDir.appendingPathComponent(fileName+".json"))
        
        // Try to read
        do {
            let readedData = try Data(contentsOf: url)
            try load(from: readedData)
        } catch {
            debugPrint("Can not read from", String(describing: url))
            throw FileManageError.canNotReadFile
        }
    }
    
    mutating func load(from data:Data) throws {
        // Try to read
        do {
            let readedInstance = try JSONDecoder().decode(Self.self, from: data)
            self = readedInstance
        } catch {
            debugPrint("Can not read from", String(describing: data))
            throw FileManageError.canNotConvertData
        }
    }
    
    mutating func load(fromString stringData:String) throws {
        // Try to read
        guard let data = stringData.data(using: .utf8) else {
            fatalError("this is not a data")
        }
        do {
            let readedInstance = try JSONDecoder().decode(Self.self, from: data)
            self = readedInstance
        } catch {
            debugPrint("Can not read from", String(describing: data))
            throw FileManageError.canNotConvertData
        }
    }
    
    mutating func load(from dictionary:[String:Any]) throws {
        
        do {
            var anyData:Any
            if let arrayData = dictionary[String(describing: type(of: self))] {
                anyData = arrayData
            } else {
                anyData = dictionary as Any
            }
            let theJSONData = try JSONSerialization.data(withJSONObject: anyData, options: [])
            try load(from: theJSONData)
        } catch {
            debugPrint("Can not convert from dictionary to", String(describing: type(of: self)))
            throw FileManageError.canNotConvertData
        }
    }
    
    mutating func load(from array:[Any]) throws {
        
        do {
            let anyData = array as Any
            let theJSONData = try JSONSerialization.data(withJSONObject: anyData, options: [])
            try load(from: theJSONData)
        } catch {
            debugPrint("Can not convert from array to", String(describing: type(of: self)))
            throw FileManageError.canNotConvertData
        }
    }
    
}

extension Data {
    
    public var asString:String {
        return String(data: self, encoding: .utf8) ?? #""ERROR": "cannot decode into String"""#
    }
    
    public var asDictionary:[AnyHashable:Codable] {

        if let dictionary = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [String: Codable] {
            return dictionary
        }
        // else
        
        if let array = self.asArray {
            return ["Array":array as! Codable]
        }
        // else
        return ["ERROR":"cannot decode into dictionary"]
    }
    
    public var asArray:[Codable]? {
        return try? JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [Codable]
    }
    
    public func convert<T>(to:T.Type) throws ->T where T:Codable {
        // Try to convert
        do {
            return try JSONDecoder().decode(T.self, from: self)
        
        } catch {
            debugPrint("cannot convert this: \(self.asString)")
            throw FileManageError.canNotDecodeData
        }
    }
}



extension Decodable {
    
    static private func url(from file:String? = nil)->URL {
        // generates URL for documentDir/file.json
        if let fileName = file {
            if fileName.lowercased().hasPrefix("http") {
                    return URL(string: fileName) ?? URL(fileURLWithPath: fileName)
            } //else
            return URL(fileURLWithPath: fileName)
        } else {
            let fileName = String(describing: self)
            let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            return URL(fileURLWithPath: documentDir.appendingPathComponent(fileName+".json"))
        }
    }
    
    static func load(from file:String? = nil)throws ->Self {
        // Try to read
        do {
            let data = try Data(contentsOf: Self.url(from: file))
            return try load(from: data)
        } catch {
            debugPrint("Can not read from", file ?? String(describing: self))
            throw FileManageError.canNotReadFile
        }
    }
    
    static func load(from data:Data)throws ->Self {
        // Try to read
        do {
            return try JSONDecoder().decode(Self.self, from: data)
        } catch {
            debugPrint("Can not read from", String(describing: data))
            throw FileManageError.canNotConvertData
        }
    }
    
    static func load(fromString stringData:String)throws ->Self{
        // Try to read
        guard let data = stringData.data(using: .utf8) else {
            fatalError("this is not a data")
        }
        do {
            return try load(from: data)
        } catch {
            debugPrint("Can not read from", String(describing: data))
            throw FileManageError.canNotConvertData
        }
    }
    
    static func load(from dictionary:[String:Any])throws ->Self{
        
        do {
            var anyData:Any
            if let arrayData = dictionary[String(describing: self)] {
                anyData = arrayData
            } else {
                anyData = dictionary as Any
            }
            let data = try JSONSerialization.data(withJSONObject: anyData, options: [])
            return try load(from: data)
        } catch {
            debugPrint("Can not convert from dictionary to", String(describing: type(of: self)))
            throw FileManageError.canNotConvertData
        }
    }
    
    static func load(from array:[Any])throws ->Self{
        
        do {
            let anyData = array as Any
            let data = try JSONSerialization.data(withJSONObject: anyData, options: [])
            return try load(from: data)
        } catch {
            debugPrint("Can not convert from array to", String(describing: type(of: self)))
            throw FileManageError.canNotConvertData
        }
    }
	
}
