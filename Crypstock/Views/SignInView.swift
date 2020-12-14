//
//  SignInView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 06/12/2020.
//

import SwiftUI

struct SignInView: View {
    @Binding var childView: String;
    let backgroundGradientColors: Gradient = Gradient(colors: [Color(red: 0.0, green: 0.7058823529, blue: 0.8588235294), Color(red: 0, green: 0.5137254902, blue: 0.6901960784)])
    var body: some View {
        ZStack {
            LinearGradient(gradient: backgroundGradientColors, startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
            Image("logo")
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 20).foregroundColor(.white).frame(minWidth: 0, maxWidth: 350, maxHeight: 450, alignment: .center)
                    HStack {
                        Text("Sign In")
                    }
                }
                Spacer()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(childView: .constant(""))
    }
}
