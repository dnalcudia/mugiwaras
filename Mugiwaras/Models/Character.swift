//
//  Person.swift
//  Character
//
//  Created by Angel Daniel Alcudia on 18/11/20.
//

import Foundation

struct Character: Identifiable, Decodable {
    
    var id: String { name }
    
    let name: String
    let description: String
    let imageName: String
    let shortDescription: String
    let sections: [CharacterSection]?
}

struct CharacterSection: Identifiable, Decodable {
    
    var id: String { name }
    
    let name: String
    let picturesImageName: [String]
}

extension Character: Equatable {
    
    static func ==(lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
}

extension Character {
    
    static var stubbed: [Character] {
        let url = Bundle.main.url(forResource: "mugiwaras_list", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let people = try! JSONDecoder().decode([Character].self, from: data)
        return people
    }
}
