//
//  HomeView.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 17/12/23.
//
import SwiftUI
struct HomeView: View {
    @State var time=Timer.publish(every:1.0, on:.main, in:.common).autoconnect()
    @State private var showSetting:Bool=false
    @EnvironmentObject private var vm : HomeViewModel
    @State private var showPortFolio:Bool = false
    @State private var showPortfolioView = false
    @State private var SelectedCoin:CoinModel?=nil
    @State private var showDetailView = false
    @State var count=0
    @State var login=true
    @State var top5=false
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented:$showPortfolioView, content: {
                    PortFolioView()
                        .environmentObject(vm)
                })
            VStack{
                homeHeader
                HomeStatView(showPortfolio:$showPortFolio)
                SearchBarView(searchText:$vm.searchText)
                HStack{
                    HStack(spacing:4){
                        Text("Coin")
                        Image(systemName:"chevron.down")
                            .opacity((vm.sortOption == .rank || vm.sortOption == .rankreversed) ? 1.0:0.0)
                            .rotationEffect(Angle(degrees:vm.sortOption == .rank ? 0:180))
                    }
                    .onTapGesture {
                        withAnimation(.default){
                            vm.sortOption = vm.sortOption == .rank ? .rankreversed:.rank
                        }
                    }
                    Spacer()
                    if showPortFolio{
                        HStack(spacing:4){
                            Text("Holdings")
                            Image(systemName:"chevron.down")
                                .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0:0.0)
                                .rotationEffect(Angle(degrees:vm.sortOption == .holdings ? 0:180))
                        }
                        .onTapGesture {
                            withAnimation(.default){
                                vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed:.holdings
                            }
                        }
                    }
                    HStack(spacing:4){
                        Text("Price")
                        Image(systemName:"chevron.down")
                            .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0:0.0)
                            .rotationEffect(Angle(degrees:vm.sortOption == .price ? 0:180))
                    }
                    .onTapGesture {
                        withAnimation(.default){
                            vm.sortOption = vm.sortOption == .price ? .priceReversed:.price
                        }
                    }
                        .frame(width:UIScreen.main.bounds.width/3.5,alignment: .trailing)
                    Button(action: {
                        withAnimation(.linear(duration:2.0)){
                            vm.reload()
                        }
                    }, label: {
                        Image(systemName:"goforward")
                    })
                    .rotationEffect(Angle(degrees:vm.isLoading ? 360:0), anchor: .center)
                }
                .font(.caption)
                .foregroundColor(Color.theme.Secondary)
                .padding(.horizontal)
                if !showPortFolio{
                    List{
                        ForEach(vm.allCoins){ coin in
                            CoinRowView(coin: coin, showHoldingsColumn: false)
                                .listRowInsets(.init(top:10, leading:0, bottom:10, trailing:10))
                                .onTapGesture {
                                    Segue(coin:coin)
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .transition(.move(edge: .leading))
                }
                if showPortFolio{
                    List{
                        ForEach(vm.portfolioCoins){ coin in
                            CoinRowView(coin: coin, showHoldingsColumn: true)
                                .listRowInsets(.init(top:10, leading:0, bottom:10, trailing:10))
                                .onTapGesture {
                                    Segue(coin:coin)
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .transition(.move(edge: .trailing))
                }
                Spacer(minLength:0)
            }
            if(login){
                LoginPage(login:$login)
            }
            if(count<=2){
                LaunchV()
            }
        }
        .onReceive(time, perform: { value in
            withAnimation(.spring){
                count=count+1
            }
        })
        .background(
            NavigationLink(destination:DetailLoadingView(Coin:$SelectedCoin),isActive:$showDetailView,label:{EmptyView()} )
        )
        
        }
    private func Segue(coin:CoinModel){
        SelectedCoin = coin
        showDetailView.toggle()
    }
    }
struct HomeView_Preview: PreviewProvider{
    static var previews: some View{
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}
extension HomeView{
    private var homeHeader: some View{
        HStack{
                CircleButtonView(iconName:showPortFolio ? "plus":"info")
                    .animation(.none)
                    .shadow(radius:5)
                    .onTapGesture {
                        if showPortFolio{
                            showPortfolioView.toggle()
                        }
                        else{
                            showSetting.toggle()
                        }
            }
            Spacer()
            Text(showPortFolio ? "Portfolio":"Live Prices")
                .animation(.none)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            Spacer()
            Text("⚡️")
                .font(.title)
                .onTapGesture {
                    top5.toggle()
                }
            CircleButtonView(iconName:"chevron.right")
                .shadow(radius:5)
                .rotationEffect(showPortFolio ? .degrees(180):.zero)
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortFolio.toggle()
                    }
                }
        }
        .sheet(isPresented:$top5, content: {
            Spark5()
        })
        .sheet(isPresented:$showSetting, content: {
            SettingsView()
        })
    }
}
