//
//  PortfolioView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 14/12/2020.
//

import SwiftUI
import Combine

struct CoinItemView: View {
    let name: String;
    let shortName: String;
    let currentValue: Double;
    let primaryColor: Color;
    let secondaryColor: Color;
    
    var body: some  View {
        let currentValueFormatted = String(format: "%.2f", currentValue)
        let randomDataGraph = generateRandomDataArray()
        HStack {
            Group {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(name)")
                            .font(.largeTitle)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("1\(shortName) = \(currentValueFormatted)$").fontWeight(.semibold)
                            Text("12390 $USD").fontWeight(.bold).font(.title2)
                        }
                    }
                    CoinItemGraph(graphData: randomDataGraph)
                }
            }.padding(20)
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 300, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 180, maxHeight: 350, alignment: .topLeading)
        .background(LinearGradient(gradient: Gradient(colors: [primaryColor, secondaryColor]), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .cornerRadius(20.0)
    }
    
    func generateRandomDataArray() -> [Double] {
        var data: [Double] = []
        let minValue = currentValue - (currentValue * 0.2)
        let maxValue = currentValue + (currentValue * 0.2)
        
        for _ in 0..<50 {
            let value = Double.random(in: minValue ..< maxValue)
            data.append(value)
        }
        print(data)
        return data
    }
    
    struct CoinItemGraph: View {
        let graphData: [Double]
        let maxWidth: Double = 300.0;
        let maxHeight: Double = 200.0;

        func generateGraph() -> Path {
            var graph = Path()
            let stepWidth: Double = maxWidth / Double(graphData.count)
            let min: Double = graphData.min() ?? 0
            let diff: Double = graphData.max() ?? 0 - min
            
            graph.move(to: CGPoint(x: 0, y: 0))
            for dataIndex in 0..<graphData.count {
                let p2 = CGPoint(x: stepWidth * Double(dataIndex), y: ((graphData[dataIndex] - min) / diff) * maxHeight)
                print(p2)
                graph.addLine(to: p2)
            }
            return graph;
        }
        
        var body: some View {
            generateGraph().stroke(Color.white ,style: StrokeStyle(lineWidth: 2, lineJoin: .round))
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
    }
}

struct Coin: Identifiable {
    var id = UUID()
    var name: String
    var shortName: String
    var currentValue: Double
    var primaryColor: String
    var secondaryColor: String
}

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
