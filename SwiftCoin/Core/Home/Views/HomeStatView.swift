//
//  HomeStatView.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 25/12/23.
//

import SwiftUI

struct HomeStatView: View {
    @EnvironmentObject var vm:HomeViewModel
    @Binding var showPortfolio:Bool
    var body: some View {
        HStack{
            ForEach(vm.statistics){ stat in
                StatisticView(stat:stat)
                    .frame(width:UIScreen.main.bounds.width/3)
            }
        }
        .frame(width:UIScreen.main.bounds.width,alignment:showPortfolio ? .trailing:.leading)
    }
}
struct HomeStat_Preview:PreviewProvider{
    static var previews: some View{
        HomeStatView(showPortfolio:.constant(false))
            .environmentObject(dev.homeVM)
    }
}
