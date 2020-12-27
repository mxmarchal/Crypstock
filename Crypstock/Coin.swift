//
//  Coin.swift
//  Crypstock
//
//  Created by Maxence Marchal on 14/12/2020.
//

import SwiftUI

struct CoinColors: Decodable {
    var primary: String
    var secondary: String
}

struct Coin: Decodable {
    var name: String
    var shortName: String
    var colors: CoinColors
    var values: [Double]
    var currentValue: Double
}

extension Coin: Identifiable {
    var id: UUID {
        return UUID()
    }
}
