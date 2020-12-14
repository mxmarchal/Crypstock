//
//  PortfolioView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 14/12/2020.
//

import SwiftUI

struct CoinItemView: View {
    let name: String;
    let primaryColor: Color;
    let secondaryColor: Color;
    
    var body: some  View {
        HStack {
            Group {
                Text("\(name)")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }.padding(20)
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 300, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 180, maxHeight: 350, alignment: .topLeading)
        .background(LinearGradient(gradient: Gradient(colors: [primaryColor, secondaryColor]), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .cornerRadius(20.0)
    }
}

struct PortfolioView: View {
    var body: some View {
        NavigationView {
            List {
                ZStack {
                    CoinItemView(name: "Bitcoin", primaryColor: Color(hex: "#FDC830"), secondaryColor: Color(hex: "#F37335"))
                    NavigationLink(destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                    }.opacity(0.0)
                }
                
                    ZStack {
                        CoinItemView(name: "Bitcoin", primaryColor: Color(hex: "#FDC830"), secondaryColor: Color(hex: "#F37335"))
                        NavigationLink(destination: Text("Destination 2")) {
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
