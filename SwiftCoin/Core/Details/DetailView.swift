//
//  DetailView.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 30/12/23.
//

import SwiftUI
struct DetailLoadingView:View{
    @Binding var Coin:CoinModel?
    var body: some View {
        ZStack{
            //Text(Coin?.name ?? "")
            if let Coin = Coin{
                DetailView(coin:Coin)
            }
        }
    }
}
struct DetailView: View {
    @State var Read:Bool=false
    @StateObject var vm:DetailViewModel
    private let Columns:[GridItem]=[
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing:CGFloat = 30
    init(coin:CoinModel){
        _vm = StateObject(wrappedValue:DetailViewModel(coin:coin))
        print("\(coin.name)")
    }
    var body: some View {
        ScrollView{
            VStack(spacing:20){
                ChartView(coin:vm.coin)
                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth:.infinity,alignment:.leading)
                Divider()
                ZStack{
                    if let coinDescription = vm.coinDescription,
                       !coinDescription.isEmpty{
                        VStack(alignment:.leading){
                            Text(coinDescription)
                                .lineLimit(Read ? nil:3)
                                .font(.callout)
                                .foregroundColor(Color.theme.Secondary)
                            Button(action:{
                                withAnimation(.easeInOut){
                                    Read.toggle()
                                }
                            }, label: {
                                Text(Read ? "Less":"Read more...")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .padding(.vertical,4)
                            })
                            .accentColor(.blue)
                        }
                        .frame(maxWidth:.infinity,alignment:.leading)
                    }
                }
                LazyVGrid(
                    columns:Columns,
                    alignment:.leading,
                    spacing:spacing,
                    pinnedViews:[],
                    content: {
                        ForEach(vm.overviewStatistics) { stat in
                            StatisticView(stat:stat)
                        }
                })
                Text("Additional Details")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth:.infinity,alignment:.leading)
                Divider()
                LazyVGrid(
                    columns:Columns,
                    alignment:.leading,
                    spacing:spacing,
                    pinnedViews:[],
                    content: {
                        ForEach(vm.addtionalStatistics) { stat in
                            StatisticView(stat:stat)
                        }
                })
                HStack{
                    if let websiteURL = vm.websiteURL,
                       let url = URL(string:websiteURL){
                        Link("Website",destination:url)
                    }
                    Spacer()
                    if let redditURL = vm.redditURL,
                       let url = URL(string:redditURL){
                        Link("Reddit",destination:url)
                            .padding()
                    }
                        
                }
                .accentColor(.blue)
                .frame(maxWidth:.infinity,alignment:.leading)
                .font(.headline)
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
        .toolbar{
            ToolbarItem(placement:.navigationBarTrailing){
                HStack{
                    Text(vm.coin.symbol.uppercased())
                        .font(.headline)
                        .foregroundColor(Color.theme.Secondary)
                    CoinImageView(coin:vm.coin)
                        .frame(width:25,height:25)
                }
            }
        }
    }
}
struct Detail_Preview:PreviewProvider{
    static var previews: some View{
        NavigationView{
            DetailView(coin:dev.coin)
        }
    }
}
