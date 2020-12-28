//
//  Coins.swift
//  Crypstock
//
//  Created by Maxence Marchal on 26/12/2020.
//

import Foundation

// REVIEW #3 - Maybe name it CoinManager

class Coins {
    func loadCoinsFromJSON() -> [Coin]? {
        guard let fileURL = Bundle.main.url(forResource: "currencies", withExtension: "json") else {
            print("File can't be loaded.")
            return nil
        }
        do {
            if let fileContents = try? String(contentsOf: fileURL) {
                guard let jsonData = fileContents.data(using: .utf8) else {
                    return nil
                }
                let coinsData: [Coin] = try! JSONDecoder().decode([Coin].self, from: jsonData)
                return coinsData
            }
        } catch {
            // REVIEW #3 - Catch is useless since you are forcecasting (!)
            print("Error: \(error)")
            return nil
        }
        return nil
    }
}
