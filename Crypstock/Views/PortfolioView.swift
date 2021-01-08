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
    @Binding var needRefresh: Bool
    
    var portfolioItems:Array<Any>? = nil
    
    func getPortfolioItems() -> Array<Coin>? {
        let coinsFinal: Array<Coin>? = user.getUserPortfolio()
        return coinsFinal
    }
    
    var body: some View {
        NavigationView {
            if let coinsData = getPortfolioItems() {
                if coinsData.count == 0 {
                    Text("portfolioNoCoins")
                } else {
                    List(coinsData) {
                        coin in ZStack {
                            NavigationLink(destination: CoinDetailsView(user: $user, needRefresh: $needRefresh, coin: coin)) {
                            }.opacity(0.0)
                            CoinItemView(coin: coin)
                        }
                    }.navigationBarTitle("portfolioListTitle")
                }
            } else {
                Text("portfolioNoCoins")
            }
        }.zIndex(self.needRefresh ? 1.0 : 1.1)
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
        PortfolioView(childView: .constant(""), user: $user, needRefresh: .constant(false))
    }
}
