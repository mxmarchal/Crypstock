//
//  PortfolioView.swift
//  Crypstock
//
//  Created by Maxence Marchal on 14/12/2020.
//

import SwiftUI
import Combine

struct PortfolioView: View {
    @Binding var childView: String
    @Binding var user: User
    
    var portfolioItems:Array<Any>? = nil;

    func getPortfolioItems() -> Text {
        user.getUserPortfolio()
        return Text("Hey")
    }
    
    var body: some View {
        NavigationView {
            Text("You don't have any coins.")
            getPortfolioItems()
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView_Previews_Container()
    }
}

struct PortfolioView_Previews_Container: View {
    @State private var user:User = User()
    
    var body: some View {
        PortfolioView(childView: .constant(""), user: $user)
    }
}
