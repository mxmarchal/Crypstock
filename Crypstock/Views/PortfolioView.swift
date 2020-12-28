//
//  PortfolioView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 14/12/2020.
//

import SwiftUI
import Combine


struct PortfolioView: View {
    @Binding var childView: String
    @Binding var user: User
/*
    let coinsData: [Coin] =
        [Coin(name: "Bitcoin", shortName: "BTC", currentValue: 15721.79, primaryColor: "#FDC830", secondaryColor: "#F37335"),
         Coin(name: "Ethereum", shortName: "ETH", currentValue: 584.67, primaryColor: "#8E2DE2", secondaryColor: "#4A00E0")
        ]
    */
    let coinsJSON: [Coin]? = Coins().loadCoinsFromJSON()

    var body: some View {
        NavigationView {
            if let coinsData = coinsJSON {
                List(coinsData) {
                    coin in
                        ZStack {
                            NavigationLink(destination: Text("\(coin.name)")) {
                            }.opacity(0.0)
                            CoinItemView(coin: coin)
                        }
                }
                .navigationBarTitle("Portfolio")
                // REVIEW #3 - Not localized.
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView_Previews_Container()
    }
}

struct PortfolioView_Previews_Container: View {
    @State private var user:User = User()
    
    var body: some View {
        PortfolioView(childView: .constant(""), user: $user)
    }
}
