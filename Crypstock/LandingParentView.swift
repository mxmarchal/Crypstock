//
//  LandingParentView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 06/12/2020.
//

import SwiftUI

struct LandingParentView: View {
    @State private var childView = "LANDING_VIEW"
    var body: some View {
        switch(childView) {
            case "LANDING_VIEW":
                LandingView(childView: $childView)
            case "SIGNIN_VIEW":
                SignInView(childView: $childView)
            case "SIGNUP_VIEW":
                SignInView(childView: $childView)
            default:
                LandingView(childView: $childView)
        }
    }
}

struct LandingParentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingParentView()
    }
}
