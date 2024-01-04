//
//  PortFolioView.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 28/12/23.
//

import SwiftUI

struct PortFolioView: View {
    @EnvironmentObject var vm:HomeViewModel
    @State private var selectedCoin:CoinModel? = nil
    @State private var quantity = ""
    @State private var showCheckmark = false
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment:.leading,spacing:0){
                    SearchBarView(searchText:$vm.searchText)
                    coinLogoList
                    if selectedCoin != nil{
                        VStack(spacing:20){
                            HStack{
                                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "")")
                                Spacer()
                                Text("₹"+(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? ""))
                            }
                            Divider()
                            HStack{
                                Text("Amount holding:")
                                Spacer()
                                TextField("Ex:1.4",text:$quantity)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                            }
                            Divider()
                            HStack{
                                Text("Curret Value:")
                                Spacer()
                                Text("₹"+getCurrentValue().asCurrencyWith2Decimals())
                            }
                        }
                        .animation(.none)
                        .padding()
                        .font(.headline)
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar{
                ToolbarItem(placement:.navigationBarLeading){
                    XmarkView()
                }
                ToolbarItem(placement:.navigationBarTrailing){
                    HStack(spacing:10){
                        Image(systemName:"checkmark")
                            .opacity(showCheckmark ? 1.0:0.0)
                        Button{
                            saveButtonPresses()
                        }label: {
                            Text("Save".uppercased())
                        }
                        .opacity(
                            (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantity)) ? 1.0:0.0
                        )
                    }
                }
            }
            .onChange(of:vm.searchText){ value in
                if value==""{
                    RemoveSelectedCoin()
                }
            }
        }
    }
}
struct PortFolio_View:PreviewProvider{
    static var previews: some View{
        PortFolioView()
            .environmentObject(dev.homeVM)
    }
}
extension PortFolioView{
    private var coinLogoList: some View{
                ScrollView(.horizontal,showsIndicators:false){
                    LazyHStack(spacing:10){
                        ForEach(vm.allCoins){ coin in
                            CoinLogoView(coin:coin)
                                .frame(width:75)
                                .padding(4)
                                .onTapGesture {
                                    withAnimation(.easeIn){
                                        updateSelectedCoin(coin:coin)
                                    }
                                }
                                .background(
                                RoundedRectangle(cornerRadius:10)
                                    .stroke(selectedCoin?.id == coin.id ? Color.theme.Green:Color.clear,lineWidth:1)
                                )
                        }
                    }
                    .frame(height:120)
                    .padding(.leading)
                }
            }
    private func updateSelectedCoin(coin:CoinModel){
        selectedCoin = coin
        if let portfolioCoin = vm.portfolioCoins.first(where:{$0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings{
            quantity = "\(amount)"
        } else{
            quantity = ""
        }
    }
    private func getCurrentValue() -> Double {
        if let quantityVal = Double(quantity){
            return quantityVal*(selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    private func saveButtonPresses(){
        guard 
            let coin = selectedCoin,
            let amount = Double(quantity)
        else{return}
        vm.updatePortfolioView(coin:coin, amount:amount)
        withAnimation(.easeIn){
            showCheckmark = true
            RemoveSelectedCoin()
        }
        UIApplication.shared.endEditing()
        DispatchQueue.main.asyncAfter(deadline:.now()+2){
            withAnimation(.easeInOut){
                showCheckmark = false
            }
        }
    }
    private func RemoveSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
    }
}
