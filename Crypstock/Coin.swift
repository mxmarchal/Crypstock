//
//  Coin.swift
//  Crypstock
//
//  Created by Maxence Marchal on 14/12/2020.
//

import SwiftUI

struct CoinColors: Decodable {
    let primary: String
    let secondary: String
}

struct Coin: Decodable {
    let name: String
    let shortName: String
    let colors: CoinColors
    let values: [Double]
    let currentValue: Double
    var quantity: Double? = nil
}

extension Coin: Identifiable {
    var id: UUID {
        return UUID()
    }
}
