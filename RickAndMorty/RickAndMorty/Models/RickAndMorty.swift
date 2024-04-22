//
//  RickAndMorty.swift
//  RickAndMorty
//
//  Created by Matvei Khlestov on 22.04.2024.
//

import Foundation

struct Character {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    
    var description: String {
        """
    Name: \(name)
    Status: \(status)
    Species: \(species)
    Gender: \(gender)
    Origin: \(origin.name)
    Location: \(location.name)
    """
    }
    
    static func getCharacters() -> [Character] {
        [
            Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                gender: "Male",
                origin: Location(name: "Earth"),
                location: Location(name: "Citadel of Ricks"),
                image: "Logo",
                episode: ["Pilot", "Lawnmower Dog", "Alexander"],
                url: "https://rickandmortyapi.com/api/character/1"
            ),
            Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                gender: "Male",
                origin: Location(name: "Earth"),
                location: Location(name: "Citadel of Ricks"),
                image: "Logo",
                episode: ["Pilot", "Lawnmower Dog", "Alexander"],
                url: "https://rickandmortyapi.com/api/character/1"
            ),
            
            Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                gender: "Male",
                origin: Location(name: "Earth"),
                location: Location(name: "Citadel of Ricks"),
                image: "Logo",
                episode: ["Pilot", "Lawnmower Dog", "Alexander"],
                url: "https://rickandmortyapi.com/api/character/1"
            )
        ]
        
    }
}

struct Location: Decodable {
    let name: String
}

struct Episode {
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    
    var description: String {
        """
    Title: \(name)
    Date: \(air_date)
    """
    }
    
    static func getEpisodes() -> [Episode] {
        [
            Episode(
                name: "Pilot",
                air_date: "22 april 2024",
                episode: "S01E01",
                characters: ["Rick", "Morty"]
            ),
            Episode(
                name: "Pilot",
                air_date: "22 april 2024",
                episode: "S01E01",
                characters: ["Rick", "Morty"]
            ),
            Episode(
                name: "Pilot",
                air_date: "22 april 2024",
                episode: "S01E01",
                characters: ["Rick", "Morty"]
            )
        ]
    }
}

