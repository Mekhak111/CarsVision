//
//  CarType.swift
//  CarsVision
//
//  Created by Mekhak Ghapantsyan on 11/14/24.
//

import Foundation

enum NissanModel: String, Codable, CaseIterable {
    case kicks2019
    case sentraSylphySL2018
    case sylphyEV2018
    case sentraSylphy2020
    case tiida2017
    case sentraSylphyEPower2021
    case kicks2021
    case muranoHybrid2015
    case qashqai2018
    case versaSedan2015
    case zRZ34Pandem2023
    case zRZ34Varis2023
    case fairladyZRZ34_2023
    case zNismo2024
    case zProtoConcept2020
    case zRocketBunny2003
    case z370Nismo2015
    case z370Coupe2018
    case z370NFS2013
    case z370_2013
    case z350TopSecret2003
    case z350Veliside2003
    case z350_2006
    case z350

    var name: String {
        switch self {
        case .kicks2019: return "2019 Nissan Kicks Sport"
        case .sentraSylphySL2018: return "2018 Nissan Sentra Sylphy SL"
        case .sylphyEV2018: return "2018 Nissan Sylphy EV Zero Emission"
        case .sentraSylphy2020: return "2020 Nissan Sentra Sylphy"
        case .tiida2017: return "2017 Nissan Tiida"
        case .sentraSylphyEPower2021: return "2021 Nissan Sentra Sylphy ePower"
        case .kicks2021: return "2021 Nissan Kicks"
        case .muranoHybrid2015: return "2015 Nissan Murano Hybrid"
        case .qashqai2018: return "2018 Nissan Qashqai"
        case .versaSedan2015: return "2015 Nissan Versa Sedan"
        case .zRZ34Pandem2023: return "2023 Nissan Z (RZ34) Pandem Widebody Kit"
        case .zRZ34Varis2023: return "2023 Nissan Z (RZ34) Varis ARISING-1 Widebody Kit"
        case .fairladyZRZ34_2023: return "2023 Nissan Fairlady Z RZ34"
        case .zNismo2024: return "2024 Nissan Z Nismo"
        case .zProtoConcept2020: return "2020 Nissan Z Proto Concept"
        case .zRocketBunny2003: return "2003 Nissan 350Z Rocket Bunny Z33"
        case .z370Nismo2015: return "2015 Nissan 370Z Nismo"
        case .z370Coupe2018: return "2018 Nissan 370Z Coupe Heritage Edition"
        case .z370NFS2013: return "2013 Nissan 370Z NFS Wide Body Kit"
        case .z370_2013: return "2013 Nissan 370Z"
        case .z350TopSecret2003: return "2003 Nissan 350Z Top Secret"
        case .z350Veliside2003: return "2003 Nissan 350Z Veliside"
        case .z350_2006: return "2006 Nissan 350Z"
        case .z350: return "Nissan 350Z"
        }
    }

    var description: String {
        switch self {
        case .kicks2019:
            return "The 2019 Nissan Kicks Sport is a compact crossover SUV known for its stylish design, efficient performance, and advanced safety features."
        case .sentraSylphySL2018:
            return "The 2018 Nissan Sentra Sylphy SL offers a balance of practicality and comfort, featuring a sleek design and a spacious interior."
        case .sylphyEV2018:
            return "The 2018 Nissan Sylphy EV Zero Emission is an eco-friendly sedan delivering zero-emission electric performance with modern technology."
        case .sentraSylphy2020:
            return "The 2020 Nissan Sentra Sylphy is a versatile sedan combining elegant design with advanced driver-assistance features."
        case .tiida2017:
            return "The 2017 Nissan Tiida is a compact hatchback known for its affordability, reliability, and fuel-efficient performance."
        case .sentraSylphyEPower2021:
            return "The 2021 Nissan Sentra Sylphy ePower features a hybrid powertrain, offering a mix of electric efficiency and internal combustion range."
        case .kicks2021:
            return "The 2021 Nissan Kicks is a subcompact SUV with a bold design, high-tech features, and efficient performance for urban driving."
        case .muranoHybrid2015:
            return "The 2015 Nissan Murano Hybrid combines luxurious comfort with hybrid efficiency, providing a premium driving experience."
        case .qashqai2018:
            return "The 2018 Nissan Qashqai is a compact crossover with a modern design, advanced safety features, and impressive cargo space."
        case .versaSedan2015:
            return "The 2015 Nissan Versa Sedan offers a spacious interior, excellent fuel economy, and great value for budget-conscious drivers."
        case .zRZ34Pandem2023:
            return "The 2023 Nissan Z (RZ34) Pandem Widebody Kit is a sports car with aggressive styling and powerful performance."
        case .zRZ34Varis2023:
            return "The 2023 Nissan Z (RZ34) Varis ARISING-1 Widebody Kit features a striking design with enhanced aerodynamics for track enthusiasts."
        case .fairladyZRZ34_2023:
            return "The 2023 Nissan Fairlady Z RZ34 blends classic Z heritage with modern sports car performance and design."
        case .zNismo2024:
            return "The 2024 Nissan Z Nismo offers enhanced aerodynamics, track-ready handling, and a more aggressive styling package."
        case .zProtoConcept2020:
            return "The 2020 Nissan Z Proto Concept previews the next-generation Z car with a blend of retro design elements and advanced technology."
        case .zRocketBunny2003:
            return "The 2003 Nissan 350Z Rocket Bunny Z33 Wide Body Kit adds bold styling to the classic Z33 sports car."
        case .z370Nismo2015:
            return "The 2015 Nissan 370Z Nismo offers track-inspired performance with sharp handling and aggressive styling."
        case .z370Coupe2018:
            return "The 2018 Nissan 370Z Coupe Heritage Edition celebrates the Z car's legacy with unique styling elements."
        case .z370NFS2013:
            return "The 2013 Nissan 370Z NFS Wide Body Kit features a customized design inspired by the popular Need for Speed franchise."
        case .z370_2013:
            return "The 2013 Nissan 370Z offers a pure sports car experience with balanced handling and a powerful V6 engine."
        case .z350TopSecret2003:
            return "The 2003 Nissan 350Z Top Secret is a performance-tuned variant with unique styling and enhanced performance capabilities."
        case .z350Veliside2003:
            return "The 2003 Nissan 350Z Veliside adds aggressive styling and custom performance tuning to the classic Z car."
        case .z350_2006:
            return "The 2006 Nissan 350Z offers timeless design and robust performance, making it a favorite among sports car enthusiasts."
        case .z350:
            return "The Nissan 350Z is a classic Z car delivering a thrilling driving experience with a focus on performance and style."
        }
    }

    var horsepower: Int {
        switch self {
        case .kicks2019, .kicks2021: return 122
        case .sentraSylphySL2018, .sentraSylphy2020: return 149
        case .sylphyEV2018: return 148
        case .tiida2017: return 106
        case .sentraSylphyEPower2021: return 134
        case .muranoHybrid2015: return 250
        case .qashqai2018: return 141
        case .versaSedan2015: return 109
        case .zRZ34Pandem2023, .zRZ34Varis2023, .fairladyZRZ34_2023, .zNismo2024: return 400
        case .zProtoConcept2020: return 405
        case .zRocketBunny2003, .z350Veliside2003, .z350TopSecret2003, .z350_2006, .z350: return 287
        case .z370Nismo2015, .z370Coupe2018, .z370NFS2013, .z370_2013: return 350
        }
    }

    var technicalSpecifications: String {
        switch self {
        case .kicks2019, .kicks2021:
            return """
                   Engine: 1.6L Inline-4
                   Transmission: Xtronic CVT
                   Drive: Front-Wheel Drive
                   Fuel Efficiency: 31 MPG city / 36 MPG highway
                   """
        case .sentraSylphySL2018, .sentraSylphy2020:
            return """
                   Engine: 2.0L Inline-4
                   Transmission: Xtronic CVT
                   Drive: Front-Wheel Drive
                   Fuel Efficiency: 29 MPG city / 39 MPG highway
                   """
        case .sylphyEV2018:
            return """
                   Battery: 40 kWh Lithium-ion
                   Range: 210 miles
                   Charging Time: 8 hours (Level 2)
                   Drive: Front-Wheel Drive
                   """
        case .tiida2017:
            return """
                   Engine: 1.6L Inline-4
                   Transmission: 5-speed manual or 4-speed automatic
                   Drive: Front-Wheel Drive
                   Fuel Efficiency: 28 MPG city / 35 MPG highway
                   """
        case .sentraSylphyEPower2021:
            return """
                   Engine: e-Power Hybrid System
                   Transmission: Single Speed
                   Drive: Front-Wheel Drive
                   Fuel Efficiency: 40 MPG combined
                   """
        case .muranoHybrid2015:
            return """
                   Engine: 2.5L Supercharged Inline-4 Hybrid
                   Transmission: Xtronic CVT
                   Drive: Front-Wheel Drive or All-Wheel Drive
                   Fuel Efficiency: 28 MPG city / 31 MPG highway
                   """
        case .qashqai2018:
            return """
                   Engine: 2.0L Inline-4
                   Transmission: Xtronic CVT
                   Drive: Front-Wheel Drive or All-Wheel Drive
                   Fuel Efficiency: 23 MPG city / 30 MPG highway
                   """
        case .versaSedan2015:
            return """
                   Engine: 1.6L Inline-4
                   Transmission: 5-speed manual or Xtronic CVT
                   Drive: Front-Wheel Drive
                   Fuel Efficiency: 31 MPG city / 39 MPG highway
                   """
        case .zRZ34Pandem2023, .zRZ34Varis2023, .fairladyZRZ34_2023:
            return """
                   Engine: 3.0L Twin-Turbo V6
                   Transmission: 6-speed manual or 9-speed automatic
                   Drive: Rear-Wheel Drive
                   """
        case .zNismo2024:
            return """
                   Engine: 3.0L Twin-Turbo V6
                   Transmission: 9-speed automatic
                   Drive: Rear-Wheel Drive
                   Nismo-tuned suspension and aerodynamics
                   """
        case .zProtoConcept2020:
            return """
                   Engine: 3.0L Twin-Turbo V6
                   Transmission: 6-speed manual
                   Drive: Rear-Wheel Drive
                   Concept vehicle with retro-inspired design
                   """
        case .zRocketBunny2003, .z350Veliside2003, .z350TopSecret2003, .z350_2006, .z350:
            return """
                   Engine: 3.5L V6
                   Transmission: 6-speed manual or 5-speed automatic
                   Drive: Rear-Wheel Drive
                   """
        case .z370Nismo2015, .z370Coupe2018, .z370NFS2013, .z370_2013:
            return """
                   Engine: 3.7L V6
                   Transmission: 6-speed manual or 7-speed automatic
                   Drive: Rear-Wheel Drive
                   """
        }
    }
  
  var modelName: String {
    switch self {
    case .kicks2019:
      "2019_Nissan_Kicks_Sport"
    case .sentraSylphySL2018: "2018_Nissan_Sentra_Sylphy_SL"
    case .sylphyEV2018:
      "2018_Nissan_Sylphy_EV_Zero_Emission"
    case .sentraSylphy2020:
      "2020_Nissan_Sentra_Sylphy"
    case .tiida2017:
      "2017_Nissan_Tiida"
    case .sentraSylphyEPower2021:
      "2021_Nissan_Sentra_Sylphy_ePower"
    case .kicks2021:
      "2021_Nissan_Kicks"
    case .muranoHybrid2015:
      "2015_Nissan_Murano_Hybrid"
    case .qashqai2018:
      "2018_Nissan_Qashqai"
    case .versaSedan2015:
      "2015_Nissan_Versa_Sedan_1"
    case .zRZ34Pandem2023:
      "2023_Nissan_Z_RZ34_Pandem_Widebody_Kit"
    case .zRZ34Varis2023:
      "2023_Nissan_Z_RZ34_Varis_ARISING-1_Widebody_Kit"
    case .fairladyZRZ34_2023:
      "2023_Nissan_Fairlady_Z_RZ34_400Z_LBNATION"
    case .zNismo2024:
      "2024_Nissan_Z_Nismo"
    case .zProtoConcept2020:
      "2020_Nissan_Z_Proto_Concept"
    case .zRocketBunny2003:
      "2003_Nissan_350Z_Rocket_Bunny_Z33_Wide_Body_Kit"
    case .z370Nismo2015:
      "2015_Nissan_370Z_Nismo_Z34"
    case .z370Coupe2018:
      "2018_Nissan_370Z_Coupe_Heritage_Edition"
    case .z370NFS2013:
      "2013_Nissan_370Z_NFS_Mobile_Wide_Body_Kit"
    case .z370_2013:
      "2013_Nissan_370Z"
    case .z350TopSecret2003:
      "2003_Nissan_350Z_Top_Secret_Z33_Super_G-Force"
    case .z350Veliside2003:
      "2003_Nissan_350Z_Veliside_Z33_Ver"
    case .z350_2006:
      "2006_Nissan_350Z"
    case .z350:
      "2006_Nissan_350Z"
    }
  }
}

