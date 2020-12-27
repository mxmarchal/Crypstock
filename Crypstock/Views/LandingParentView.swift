//
//  LandingParentView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 06/12/2020.
//

import SwiftUI

struct LandingParentView: View {
    @State private var childView = "LANDING_VIEW"
    @State private var user:User = User()

    var body: some View {
        switch(childView) {
            case "LANDING_VIEW":
                LandingView(childView: $childView)
            case "SIGNIN_VIEW":
                SignInView(childView: $childView, user: $user)
            case "SIGNUP_VIEW":
                SignUpView(childView: $childView, user: $user)
            default:
                TabView {
                    PortfolioView(childView: $childView, user: $user)
                         .tabItem {
                            Image(systemName: "phone.fill")
                            Text("Portfolio")
                          }
                }
        }
    }
}

struct LandingParentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingParentView().environment(\.colorScheme, .dark)
    }
}
