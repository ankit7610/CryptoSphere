//
//  Spark5.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 03/01/24.
//

import SwiftUI

struct Spark5: View {
    var body: some View {
        NavigationView{
        VStack{
            List {
                VStack{
                    HStack{
                        Text("1.")
                            .font(.system(size:25))
                            .bold()
                        Image("btc")
                            .resizable()
                            .frame(width:70,height:70)
                        Text("Bitcoin")
                            .font(.system(size:25))
                            .bold()
                        
                    }
                    .padding()
                    HStack{
                        Text("2.")
                            .font(.system(size:25))
                            .bold()
                        Image("eth")
                            .resizable()
                            .frame(width:40,height:40)
                            .offset(x:10)
                        Text("Ethereum")
                            .font(.system(size:25))
                            .bold()
                            .offset(x:10)
                        
                    }
                    .padding()
                    HStack{
                        Text("3.")
                            .font(.system(size:25))
                            .bold()
                            .offset(x:-17)
                        Image("tether")
                            .resizable()
                            .frame(width:40,height:40)
                        Text("Tether")
                            .font(.system(size:25))
                            .bold()
                        
                    }
                    .padding()
                    HStack{
                        Text("4.")
                            .font(.system(size:25))
                            .bold()
                            .offset(x:-10)
                        Image("solana")
                            .resizable()
                            .frame(width:40,height:40)
                        Text("Solana")
                            .font(.system(size:25))
                            .bold()
                        
                    }
                    .padding()
                    HStack{
                        Text("5.")
                            .font(.system(size:25))
                            .bold()
                        Image("bnb")
                            .resizable()
                            .frame(width:50,height:50)
                        Text("Bitcoin")
                            .font(.system(size:25))
                            .bold()
                        
                    }
                    .padding()
                }
            }
            }
        .navigationTitle("Top 5 Crypto Gems")
        }
    }
}
struct Spark_Preview: PreviewProvider{
    static var previews: some View{
        Spark5()
    }
}
