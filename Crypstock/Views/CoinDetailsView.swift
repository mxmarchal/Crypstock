//
//  CoinDetailsView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 07/01/2021.
//

import SwiftUI

enum ActiveAlert {
    case error, noValue
}

struct CoinDetailsView: View {
    @Binding var user: User
    @State var inputValue: Int = 0
    @Binding var needRefresh: Bool
    @State var coin: Coin
    
    //Alert
    @State private var activeAlert: ActiveAlert = .error
    @State private var showingAlert: Bool = false;
    @State private var showingAlertValue0: Bool = false;
    
    
    
    struct CoinDetailsInput: View {
        @Binding var inputValue: Int

        var body: some View {
            HStack {
                Button(action: {
                    if inputValue > 0 {
                        inputValue -= 1
                    }
                }){
                    Text("-").font(.title).fontWeight(.bold)
                }.padding(.all, 15.0).background(Color(.lightGray)).cornerRadius(10).foregroundColor(.white)
                Spacer()
                Text("\(inputValue)")
                Spacer()
                Button(action: {
                    inputValue += 1
                }){
                    Text("+").font(.title).fontWeight(.bold)
                }.padding(.all, 15.0).background(Color(.lightGray)).cornerRadius(10).foregroundColor(.white)
            }
        }
    }
    
    struct CoinDetailsButton: View {
        @Binding var user: User
        @Binding var inputValue: Int
        @Binding var needRefresh: Bool
        @Binding var coin: Coin

        let buttonText: Text
        let colorHexa: String
        let isSell: Bool
        
        //Alert bindings
        @Binding var showingAlert: Bool
        @Binding var activeAlert: ActiveAlert
        
        var body: some View {
            HStack {
                Button(action: {
                    let value = Double(inputValue)
                    if (value != 0) {
                        let res = user.updateUserPotfolio(coin: coin, value: value, isSell: isSell)
                        print(res)
                        if (res == true) {
                            self.needRefresh.toggle()
                            self.inputValue = 0
                            if (self.coin.quantity == nil) {
                                self.coin.quantity = value
                            } else {
                                self.coin.quantity! += value
                            }
                        } else {
                            self.activeAlert = .error
                            self.showingAlert = true
                        }
                    } else {
                        self.activeAlert = .noValue
                        self.showingAlert = true
                    }
                }) {
                    Spacer()
                    buttonText
                    Spacer()
                }
                .padding()
                .background(Color(hex: colorHexa))
                .foregroundColor(.white)
                .cornerRadius(10)
                .alert(isPresented: $showingAlert) {
                    switch activeAlert {
                    case .error:
                        return Alert(title: Text("coinDetailsAlertErrorTitle"), message: Text("coinDetailsAlertErrorMessage"), dismissButton: .default(Text("coinDetailsAlertErrorButton")))
                    case .noValue:
                        return Alert(title: Text("coinDetailsAlertNoValueTitle"), message: Text("coinDetailsAlertNoValueMessage"), dismissButton: .default(Text("coinDetailsAlertNoValueButton")))
                    }
                }
            }
        }
    }
    
    struct CoinDetailsTransactions: View {
        let transactions: [CoinTransaction]? = [CoinTransaction(value: 1200, timestamp: 1000000)]
        
        func getDateTransaction(timestamp: TimeInterval) -> String {
            let date = Date(timeIntervalSince1970: timestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yy HH:mm"
            
            return dateFormatter.string(from: date)
        }
        
        var body: some View {
            VStack {
            Text("coinDetailsTransactionTitle").font(.largeTitle).fontWeight(.bold)
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            if transactions?.count == 0 {
                Text("coinDetailsNoTransaction")
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
            CoinDetailsInput(inputValue: $inputValue)
            HStack {
                CoinDetailsButton(user:$user, inputValue: $inputValue, needRefresh: $needRefresh, coin: $coin, buttonText: Text("coinDetailsButtonBuy"), colorHexa: "#e74c3c", isSell: false, showingAlert: $showingAlert, activeAlert: $activeAlert)
                CoinDetailsButton(user:$user, inputValue: $inputValue, needRefresh: $needRefresh, coin: $coin, buttonText: Text("coinDetailsButtonSell"), colorHexa: "#27ae60", isSell: true, showingAlert: $showingAlert, activeAlert: $activeAlert)
            }
            CoinDetailsTransactions()
        }
        .padding(.horizontal, 10.0)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct CoinDetailsView_Previews_Container: View {

    @State private var user:User = User()
    @State var needRefresh:Bool = false
    
    var body: some View {
        CoinDetailsView(user: $user, needRefresh: $needRefresh, coin: Coin(name: "Bitcoin", shortName: "BTC", colors: CoinColors(primary: "#FDC830", secondary: "#F37335"), values: [234.34, 324.23, 456.32, 600.1], currentValue: 220.30))
    }
}

struct CoinDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailsView_Previews_Container()
    }
}
