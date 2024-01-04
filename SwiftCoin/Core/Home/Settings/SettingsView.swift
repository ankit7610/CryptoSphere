//
//  SettingsView.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 01/01/24.
//

import SwiftUI

struct SettingsView: View {
    let defaultURL=URL(string:"https://bitcoin.org/en/")!
    let coinGekoUrl=URL(string:"https://www.coingecko.com")!
    var body: some View {
        NavigationView{
            List{
                Section(header:Text("CryptoSphere")){
                    VStack(alignment:.leading){
                        Image("logo")
                            .resizable()
                            .frame(width:100,height:100)
                            .clipShape(RoundedRectangle(cornerRadius:20))
                        Text("This App uses MVVM, Combine and CoreData!")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.accent)
                    }
                    .padding()
                    Link("Bitcoin", destination:defaultURL)
                }
                Section(header:Text("CoinGecko")){
                    VStack(alignment:.leading){
                        Image("coingecko")
                            .resizable()
                            .frame(height:100)
                            .clipShape(RoundedRectangle(cornerRadius:20))
                        Text("This App uses CoinGecko which is an Free API for CryptoCurrency Data")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.accent)
                    }
                    .padding()
                    Link("Visit CoinGecko", destination:coinGekoUrl)
                }
                Section(header:Text("Application")){
                        Text("Terms of Service")
                        .foregroundColor(.blue)
                        Text("Privacy Policy")
                        .foregroundColor(.blue)
                        Text("Learn More")
                        .foregroundColor(.blue)
                        Text("About")
                        .foregroundColor(.blue)
                }
            }
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItem(placement:.navigationBarLeading){
                    XmarkView()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
