//
//  SignInView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 06/12/2020.
//

import SwiftUI

struct SignInView: View {
    @Binding var childView: String
    @State var username: String = ""
    
    var user: UserManagement!
    
    init(childView: Binding<String>) {
        /*
         TODO:
         My first implementatio to handle multiple views is fuck up with this user management.
         There migth be a way to have theses "Binding" variables from parent to children and I'll have to fix this before continue the user management class.
         Will see to use some kind of stage management that can do this for me easily, to search on Google.
         */
        self.childView = childView
        do {
            user = try UserManagement()
            print(user ?? "nil")
        } catch let error {
            print(error);
        }
    }

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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(childView: .constant(""))
    }
}
