//
//  Superhero.swift
//  HeroWidget
//
//  Created by Mehmet Jiyan Atalay on 19.03.2024.
//

import Foundation
struct Superhero : Identifiable, Codable {
    let name : String
    let realName : String
    let image : String
    
    var id : String {image}
}

let superman = Superhero(name: "Superman", realName: "Clark Kent", image: "superman")
let batman = Superhero(name: "Batman", realName: "Bruce Wayne", image: "batman")
let ironman = Superhero(name: "Ironman", realName: "Tony Stark", image: "ironman")
