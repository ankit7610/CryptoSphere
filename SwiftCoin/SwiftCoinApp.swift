//
//  SwiftCoinApp.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 25/10/23.
//

import SwiftUI

@main
struct SwiftCoinApp: App {
    @StateObject private var vm = HomeViewModel()
    @State var showlaunchview:Bool=false
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationView{
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(vm)
            }
        }
    }
}
