//
//  CrypstockApp.swift
//  Crypstock
//
//  Created by Maxence Marchal on 06/12/2020.
//

import SwiftUI

@main
struct CrypstockApp: App {

    var body: some Scene {
        /*
         TODO: Find a way to have tabbar and this one
        WindowGroup {
            LandingParentView()
        }
         */
        WindowGroup {
            TabView {
                PortfolioView()
                     .tabItem {
                        Image(systemName: "phone.fill")
                        Text("Portfolio")
                      }
                PortfolioView()
                     .tabItem {
                        Image(systemName: "phone.fill")
                        Text("Portfolio2")
                      }
            }
        }
    }
}
