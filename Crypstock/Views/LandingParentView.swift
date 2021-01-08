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
    @State var needRefresh: Bool = false
    
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
                PortfolioView(childView: $childView, user: $user, needRefresh: $needRefresh).tabItem {
                    Image(systemName: "phone.fill")
                    Text("tabBarPortfolio")
                }
                ListCoinsView(childView: $childView, user: $user, needRefresh: $needRefresh).tabItem {
                    Image(systemName: "phone.fill")
                    Text("tabBarAvailableCoins")
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
