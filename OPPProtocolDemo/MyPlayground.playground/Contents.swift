//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol Bird {
    var name: String {get}
    var canFly: Bool {get}
}

extension Bird where Self: Flyable {
    var canFly: Bool {return true}
}

protocol Flyable {
    var airspeedVelocity: Double {get}
}

struct FlappyBird: Bird, Flyable {
    let name: String
    let flappyAmplitude: Double
    let flappyFrequency: Double
    let canFly = true
    var airspeedVelocity: Double {
        return 3 * flappyFrequency * flappyAmplitude
    }
}


class Preson {
    let name: String
    let age: Float
    
    init() {
        self.name = ""
        self.age = 18
    }
}


struct Penguin: Bird {
    let name: String
    let canFly = false
    
}

struct SwiftBird: Bird, Flyable {
    var name: String {return "Swift\(version)"}
    let version: Double
    let canFly = true
    
    var airspeedVelocity: Double {return 20000.0}
}

enum UnladenSwallow: Bird, Flyable {
    case African
    case European
    case Unkown
    var name: String {
        switch self {
        case .African:
            return "African"
        case .European:
            return "European"
        case .Unkown:
            return "What do you mean? African or European"
        }
    }
    
    var airspeedVelocity: Double {
        switch self {
        case .African:
            return 10.0
        case .European:
            return 9.9
        case .Unkown:
            fatalError("You are throw from the bridge of death!")
        }
    }
}
















