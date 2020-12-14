//
//  PortfolioView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 14/12/2020.
//

import SwiftUI
import Combine


struct PortfolioView: View {
    let coinsData: [Coin] =
        [Coin(name: "Bitcoin", shortName: "BTC", currentValue: 15721.79, primaryColor: "#FDC830", secondaryColor: "#F37335"),
         Coin(name: "Ethereum", shortName: "ETH", currentValue: 584.67, primaryColor: "#8E2DE2", secondaryColor: "#4A00E0")
        ]

    var body: some View {
        NavigationView {
            List(coinsData) {
                coin in
                    ZStack {
                        CoinItemView(name: coin.name, shortName: coin.shortName, currentValue: coin.currentValue, primaryColor: Color(hex: coin.primaryColor), secondaryColor: Color(hex: coin.secondaryColor))
                        NavigationLink(destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                        }.opacity(0.0)
                    }
            }
            .navigationBarTitle("Portfolio")
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
