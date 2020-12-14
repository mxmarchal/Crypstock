//
//  Coin.swift
//  Crypstock
//
//  Created by Maxence Marchal on 14/12/2020.
//

import SwiftUI

struct Coin: Identifiable {
    var id = UUID()
    var name: String
    var shortName: String
    var currentValue: Double
    var primaryColor: String
    var secondaryColor: String
}
