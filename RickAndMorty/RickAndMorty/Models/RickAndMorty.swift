//
//  RickAndMorty.swift
//  RickAndMorty
//
//  Created by Matvei Khlestov on 22.04.2024.
//

import Foundation

struct RickAndMorty: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let pages: Int
    let next: URL?
    let prev: URL?
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Location
    let location: Location
    let image: URL
    let episode: [URL]
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
}

struct Location: Decodable {
    let name: String
}

struct Episode: Decodable {
    let name: String
    let air_date: String
    let episode: String
    let characters: [URL]
    
    var description: String {
        """
    Title: \(name)
    Date: \(air_date)
    """
    }
}

enum RickAndMortyAPI {
    case baseURL
    
    var url: URL {
        guard let baseURL = URL(string: "https://rickandmortyapi.com/api/character") else {
            fatalError("Invalid base URL")
        }
        return baseURL
    }
}

