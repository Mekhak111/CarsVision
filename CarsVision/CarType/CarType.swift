//
//  CarType.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import Foundation

enum NissanModel: String, Codable, CaseIterable {

    case altima
    case rogue
    case leaf
    case gtr

    var name: String {
        switch self {
        case .altima: return "Nissan Altima"
        case .rogue: return "Nissan Rogue"
        case .leaf: return "Nissan Leaf"
        case .gtr: return "Nissan GT-R"
        }
    }

    var description: String {
        switch self {
        case .altima:
            return """
                   The Nissan Altima is a midsize sedan offering a balance of comfort, performance, and fuel efficiency.
                   With a streamlined design, it provides a smooth driving experience and advanced safety features.
                   """

        case .rogue:
            return """
                   The Nissan Rogue is a compact SUV known for its spacious interior and versatile cargo space.
                   Equipped with intelligent all-wheel drive, it’s ideal for families and outdoor adventures.
                   """

        case .leaf:
            return """
                   The Nissan Leaf is a pioneering electric vehicle, offering zero emissions and a smooth, quiet ride.
                   Known for its efficiency, it features advanced technology for an eco-friendly driving experience.
                   """

        case .gtr:
            return """
                   The Nissan GT-R is a high-performance sports car with a powerful twin-turbo V6 engine.
                   Known as 'Godzilla', it delivers exceptional speed, precision handling, and a luxurious interior.
                   """
        }
    }

    var horsepower: Int {
        switch self {
        case .altima: return 188
        case .rogue: return 181
        case .leaf: return 147
        case .gtr: return 565
        }
    }

    var technicalSpecifications: String {
        switch self {
        case .altima:
            return """
                   Engine: 2.5L Inline-4
                   Transmission: Xtronic CVT
                   Drive: Front-Wheel Drive
                   Fuel Efficiency: 28 MPG city / 39 MPG highway
                   """
        case .rogue:
            return """
                   Engine: 2.5L Inline-4
                   Transmission: Xtronic CVT
                   Drive: Intelligent All-Wheel Drive
                   Fuel Efficiency: 26 MPG city / 33 MPG highway
                   """
        case .leaf:
            return """
                   Battery: 40 kWh Lithium-ion
                   Range: Up to 150 miles
                   Drive: Front-Wheel Drive
                   Charging Time: 8 hours (240V)
                   """
        case .gtr:
            return """
                   Engine: 3.8L Twin-Turbo V6
                   Transmission: 6-speed dual-clutch automatic
                   Drive: All-Wheel Drive
                   0-60 mph: 2.9 seconds
                   """
        }
    }
}
