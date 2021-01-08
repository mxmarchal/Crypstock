//
//  ListCoinsView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 07/01/2021.
//

import SwiftUI

struct ListCoinsView: View {
    @Binding var childView: String
    @Binding var user: User
    @Binding var needRefresh: Bool
    
    let coinsJSON: [Coin]? = Coins().loadCoinsFromJSON()

    var body: some View {
        NavigationView {
            if let coinsData = coinsJSON {
                List(coinsData) {
                    coin in
                        ZStack {
                            NavigationLink(destination: CoinDetailsView(user: $user, needRefresh: $needRefresh, coin: coin)) {
                            }.opacity(0.0)
                            CoinItemView(coin: coin)
                        }
                }
                .navigationBarTitle("Coins available")
            }
        }
    }
}

struct ListCoinsView_Previews: PreviewProvider {
    static var previews: some View {
        ListCoinsView_Previews_Container()
    }
}

struct ListCoinsView_Previews_Container: View {
    @State private var user:User = User()
    
    var body: some View {
        ListCoinsView(childView: .constant(""), user: $user, needRefresh: .constant(false))
    }
}
