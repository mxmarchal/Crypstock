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

struct LandingButtons: View {
    struct ButtonStyle: ViewModifier {
        func body(content: Content) -> some View {
            content.foregroundColor(.blue).background(Color(.white)).cornerRadius(50)
        }
    }
    
    struct ButtonTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            content.frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
        }
    }
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Text("Sign In").modifier(ButtonTextStyle())
            }.modifier(ButtonStyle())
            Button(action: {}) {
                Text("Sign Up").modifier(ButtonTextStyle())
            }.modifier(ButtonStyle())
        }.padding([.leading, .trailing], 40).padding(.top, 60)
    }
}

struct LandingView: View {
    @Binding var childView: String;
    let backgroundGradientColors: Gradient = Gradient(colors: [Color(red: 0.0, green: 0.7058823529, blue: 0.8588235294), Color(red: 0, green: 0.5137254902, blue: 0.6901960784)])
    var body: some View {
        ZStack {
            LinearGradient(gradient: backgroundGradientColors, startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
                Image("logo")
                LazyHStack {
                    LandingScroll()
                }
                LandingButtons()
                Button(action: {
                    childView = "SIGNIN_VIEW"
                }){
                    Text("test");
                }
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView(childView: .constant(""))
    }
}
