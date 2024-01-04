//
//  CoinRowView.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 21/12/23.
//

import SwiftUI

struct CoinRowView: View {
    let coin : CoinModel
    let showHoldingsColumn:Bool
    var body: some View {
        HStack(spacing:0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.Secondary)
                .frame(minWidth:30)
             CoinImageView(coin:coin)
             .frame(width:30,height:30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(Color.theme.accent)
            Spacer()
            if showHoldingsColumn{
                VStack(alignment:.trailing){
                    Text("₹\(coin.currentHoldingsValue.asCurrencyWith2Decimals())")
                    Text((coin.currentHoldings ?? 0).asNumberString())
                }
                .foregroundColor(Color.theme.accent)
            }
            VStack(alignment:.trailing){
                Text("₹\(coin.currentPrice.asCurrencyWith6Decimals())")
                    .bold()
                    .foregroundColor(Color.theme.accent)
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                    .foregroundColor(
                        (coin.priceChangePercentage24H ?? 0)>=0 ?
                        Color.theme.Green:Color.theme.Red
                    )
            }
            .frame(width:UIScreen.main.bounds.width/3.5,alignment: .trailing)
        }
        .font(.subheadline)
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}

struct CoinRowView_Previews: PreviewProvider{
    static var previews: some View{
        CoinRowView(coin: dev.coin,showHoldingsColumn:true)
    }
}
