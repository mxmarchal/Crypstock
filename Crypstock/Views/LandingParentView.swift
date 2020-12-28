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
        // REVIEW #3 - Could be an enum
            case "LANDING_VIEW":
                LandingView(childView: $childView)
            case "SIGNIN_VIEW":
                SignInView(childView: $childView, user: $user)
            case "SIGNUP_VIEW":
                SignUpView(childView: $childView, user: $user)
            default:
                // REVIEW #3 - May also want this one to be a value type.
                TabView {
                    PortfolioView(childView: $childView, user: $user)
                         .tabItem {
                            Image(systemName: "phone.fill")
                            // REVIEW #3 - Extract.
                            Text("Portfolio")
                            // REVIEW #3 - Not localized.
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
