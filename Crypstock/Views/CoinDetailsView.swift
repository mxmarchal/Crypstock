//
//  CoinDetailsView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 07/01/2021.
//

import SwiftUI

struct CoinDetailsView: View {
    let coin: Coin
    
    struct CoinDetailsButton: View {
        let text: String;
        let colorHexa: String;
        
        var body: some View {
            VStack {
                Button(action: {
                    
                }) {
                    Spacer()
                    Text("\(text)")
                    Spacer()
                }
                .padding()
                .background(Color(hex: colorHexa))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
    
    struct CoinDetailsTransactions: View {
        let transactions: [CoinTransaction]? = [CoinTransaction(value: 1200, timestamp: 1)]
        
        func getDateTransaction(timestamp: TimeInterval) -> String {
            let date = Date(timeIntervalSince1970: timestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yy HH:mm"
            
            return dateFormatter.string(from: date)
        }
        
        var body: some View {
            VStack {
            Text("Transactions").font(.largeTitle).fontWeight(.bold)
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            if transactions?.count == 0 {
                Text("No transactions recored.")
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding(.top, 15.0)
            } else {
                if let transactionsData = transactions {
                    List(transactionsData) {
                        transaction in
                        let valueTrunc = String(format: "%.2f", transaction.value)
                        Text("\(valueTrunc)")
                            .font(.body)
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(getDateTransaction(timestamp: transaction.timestamp))")
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                    }
                    
                }
            }
        }
    }

    var body: some View {
        VStack() {
            CoinItemView(coin: coin).frame(minWidth: 0, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            HStack {
                CoinDetailsButton(text: "Buy", colorHexa: "#e74c3c")
                CoinDetailsButton(text: "Sell", colorHexa: "#27ae60")
            }
            CoinDetailsTransactions()
        }
        .padding(/*@START_MENU_TOKEN@*/.all, 11.0/*@END_MENU_TOKEN@*/)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct CoinDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailsView(coin: Coin(name: "Bitcoin", shortName: "BTC", colors: CoinColors(primary: "#FDC830", secondary: "#F37335"), values: [234.34, 324.23, 456.32, 600.1], currentValue: 220.30))
    }
}
