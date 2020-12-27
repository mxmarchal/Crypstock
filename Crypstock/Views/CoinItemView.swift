//
//  CoinItemView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 14/12/2020.
//

import SwiftUI

struct CoinItemView: View {
    let coin: Coin;

    var body: some  View {
        let currentValueFormatted = String(format: "%.2f", coin.currentValue)
        let randomDataGraph = generateRandomDataArray()
        HStack {
            Group {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(coin.name)")
                            .font(.largeTitle)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("1\(coin.shortName) = \(currentValueFormatted)$").fontWeight(.semibold)
                            Text("12390 $USD").fontWeight(.bold).font(.title2)
                            //Check currencies swift google
                        }
                    }
                    CoinItemGraph(graphData: randomDataGraph)
                }
            }.padding(20)
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 300, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 180, maxHeight: 350, alignment: .topLeading)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: coin.colors.primary), Color(hex: coin.colors.secondary)]), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .cornerRadius(20.0)
    }
    
    func generateRandomDataArray() -> [Double] {
        var data: [Double] = []
        let minValue = coin.currentValue - (coin.currentValue * 0.2)
        let maxValue = coin.currentValue + (coin.currentValue * 0.2)
        
        for _ in 0..<50 {
            let value = Double.random(in: minValue ..< maxValue)
            data.append(value)
        }
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
//
//struct CoinItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinItemView(name: "Bitcoin", shortName: "BTC", currentValue: 234.32, primaryColor: .red, secondaryColor: .black)
//    }
//}
