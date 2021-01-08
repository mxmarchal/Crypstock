//
//  Transaction.swift
//  Crypstock
//
//  Created by Maxence Marchal on 08/01/2021.
//

import Foundation

struct CoinTransaction: Identifiable {
    let id = UUID()
    let value: Double
    let timestamp: TimeInterval
}
