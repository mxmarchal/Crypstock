//
//  LandingView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 06/12/2020.
//

import SwiftUI

struct LandingScroll: View {
    var body: some View {
        TabView {
            ForEach(1..<3) { i in
                VStack {
                    Image("LandingSlide\(i)")
                }.clipShape(RoundedRectangle(cornerRadius: 10.0, style:.continuous))
            }
            .padding(.bottom, 50)
            .padding(.all, 10)
        }
        .frame(width: UIScreen.main.bounds.width, height: 700)
        .tabViewStyle(PageTabViewStyle())
    }
}

struct LandingView: View {
    let backgroundGradientColors: Gradient = Gradient(colors: [Color(red: 0.0, green: 0.7058823529, blue: 0.8588235294), Color(red: 0, green: 0.5137254902, blue: 0.6901960784)])
    var body: some View {
        ZStack {
            LinearGradient(gradient: backgroundGradientColors, startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
                Image("logo")
                LazyHStack {
                    LandingScroll()
                }
                HStack {
                    Button(action: {}) {
                        Text("Sign In").frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                    }.foregroundColor(.blue).background(Color(.white)).cornerRadius(50)
                    Button(action: {}) {
                        Text("Sign Up").frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                    }.foregroundColor(.blue).background(Color(.white)).cornerRadius(50)
                }.padding([.leading, .trailing], 40).padding(.top, 60)
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
