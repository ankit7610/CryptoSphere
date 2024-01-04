//
//  StatisticView.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 25/12/23.
//

import SwiftUI

struct StatisticView: View {
    let stat:StatisticModel
    var body: some View {
        VStack(alignment:.leading,spacing:4){
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.Secondary)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack(spacing:4){
                Image(systemName:"triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees:(stat.percentageChange ?? 0) >= 0 ? 0:180)
                    )
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.Green:Color.theme.Red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}
struct Statistic_View:PreviewProvider{
    static var previews: some View{
        StatisticView(stat:dev.stat3)
    }
}
