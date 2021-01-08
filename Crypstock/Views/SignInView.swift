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
    
    //form
    @State var username: String = "max@max"
    @State var password: String = "max"
    
    //Alert
    @State private var showingAlert = false
    

    let backgroundGradientColors: Gradient = Gradient(colors: [Color(red: 0.0, green: 0.7058823529, blue: 0.8588235294), Color(red: 0, green: 0.5137254902, blue: 0.6901960784)])
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: backgroundGradientColors, startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
            Image("logo")
                ZStack {
                    VStack {
                        Text("signInPageTitle")
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 23.0)
                            .foregroundColor(.white)
                            .font(.title)
                        HStack {
                            Image(systemName: "person").foregroundColor(.secondary)
                            TextField("signInPageEmail", text: $username).foregroundColor(.black).autocapitalization(.none)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        HStack {
                            Image(systemName: "person").foregroundColor(.secondary)
                            SecureField("signInPagePassword", text: $password).foregroundColor(.black)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        HStack {
                            Spacer()
                            HStack {
                                Button(action: {
                                    let requestStatus = user.getUser(inputEmail: username, inputPassword: password)
                                    if requestStatus {
                                        childView = "APP"
                                    } else {
                                        self.showingAlert = true
                                    }
                                }, label: {
                                    Text("signInPageButton")
                                }).alert(isPresented: $showingAlert) {
                                    Alert(title: Text("signInPageAlertTitle"), message: Text("signInPageAlertMessage"), dismissButton: .default(Text("signInPageAlertButton")))
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                        .padding(.top, 11.0)
                    }
                    .padding(.horizontal, 23.0)
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
