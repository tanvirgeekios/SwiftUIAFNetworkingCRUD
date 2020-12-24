//
//  AFNetworkingCRUDApp.swift
//  AFNetworkingCRUD
//
//  Created by MD Tanvir Alam on 21/12/20.
//

import SwiftUI

@main
struct AFNetworkingCRUDApp: App {
    @AppStorage("isDarkMood") private var isDarkMood = false
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }.environment(\.colorScheme, isDarkMood ? .dark : .light)
        }
    }
}
