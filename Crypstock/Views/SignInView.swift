//
//  SignInView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 06/12/2020.
//

import SwiftUI

struct SignInView: View {
    @Binding var childView: String
    @Binding var user: User
    @State var username: String = ""
    

    let backgroundGradientColors: Gradient = Gradient(colors: [Color(red: 0.0, green: 0.7058823529, blue: 0.8588235294), Color(red: 0, green: 0.5137254902, blue: 0.6901960784)])
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: backgroundGradientColors, startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
            Image("logo")
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 20).foregroundColor(.white).frame(minWidth: 0, maxWidth: 350, maxHeight: 450, alignment: .center)
                    VStack {
                        Text("Sign In").font(.largeTitle)
                        TextField("Username / E-mail address", text: $username)
                        Button(action: {
                            user.createUser(inputEmail: "maxence.marchal@gmail.com", inputPassword: "password")
                        }, label: {
                            Text("Test user")
                        })
                        Button(action: {
                            childView = "APP"
                        }, label: {
                            Text("Next")
                        })
                    }.padding(20)
                }
                Spacer()
            }
        }
    }
}

/*
    IMPORTANT:
    This container exist because of binding User class for SignInView.
    With this container, I can still do the preview without any problem.
*/
struct SignInView_Previews_Container: View {
    @State private var user:User = User()
    
    var body: some View {
        SignInView(childView: .constant(""), user: $user)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView_Previews_Container()
    }
}
