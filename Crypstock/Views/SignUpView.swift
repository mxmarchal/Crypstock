//
//  SignInView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 06/12/2020.
//

import SwiftUI

struct SignUpView: View {
    @Binding var childView: String
    @Binding var user: User
    
    //form
    @State var username: String = ""
    @State var password: String = ""
    
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
                        Text("signUpPageTitle")
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 23.0)
                            .foregroundColor(.white)
                            .font(.title)
                        HStack {
                            Image(systemName: "person").foregroundColor(.secondary)
                            TextField("signUpPageEmail", text: $username).foregroundColor(.black).autocapitalization(.none)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        HStack {
                            Image(systemName: "person").foregroundColor(.secondary)
                            SecureField("signUpPagePassword", text: $password).foregroundColor(.black)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        HStack {
                            HStack {
                                Button(action: {
                                    childView = "LANDING_VIEW"
                                }, label: {
                                    Text("signUpButtonBack")
                                })
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            Spacer()
                            HStack {
                                Button(action: {
                                    do {
                                        let confirmUser: Bool = try user.createUser(inputEmail: username, inputPassword: password)
                                        if (confirmUser) {
                                            childView = "SIGNIN_VIEW"
                                        } else {
                                            self.showingAlert = true
                                        }
                                    } catch {
                                        self.showingAlert = true
                                    }
                                    //Show alert that say no
                                }, label: {
                                    Text("signUpPageButton")
                                }).alert(isPresented: $showingAlert) {
                                    Alert(title: Text("signUpPageAlertTitle"), message: Text("signUpPageAlertMessage"), dismissButton: .default(Text("signUpPageAlertButton")))
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
 This container exist because of binding User class for SignUpView.
 With this container, I can still do the preview without any problem.
 */

struct SignUpView_Previews_Container: View {
    @State private var user:User = User()
    
    var body: some View {
        SignUpView(childView: .constant(""), user: $user)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView_Previews_Container()
    }
}
