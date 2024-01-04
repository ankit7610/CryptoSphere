//
//  ChartView.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 31/12/23.
//

import SwiftUI

struct ChartView: View {
    let data:[Double]
    let maxY:Double
    let minY:Double
    let lineColor:Color
    let StartingDate:Date
    let EndingDate:Date
    @State private var percentage:CGFloat=0
    init(coin:CoinModel){
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        let priceChange = (data.last ?? 0)-(data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.Green:Color.theme.Red
        EndingDate = Date(coinGeckoString:coin.lastUpdated ?? "")
        StartingDate = EndingDate.addingTimeInterval(-7*24*60*60)
    }
    var body: some View {
        VStack{
            chartview
                .frame(height:200)
                .background(
                    VStack{
                        Divider()
                        Spacer()
                        Divider()
                        Spacer()
                        Divider()
                    }
                )
                .overlay(
                    VStack{
                        Text(maxY.formattedWithAbbreviations())
                        Spacer()
                        Text(((maxY+minY)/2).formattedWithAbbreviations())
                        Spacer()
                        Text(minY.formattedWithAbbreviations())
                    }
                    ,alignment:.leading
                )
            HStack{
                Text(StartingDate.asShortDateString())
                Spacer()
                Text(EndingDate.asShortDateString())
            }
            
        }
        .padding(.horizontal,4)
        .font(.caption)
        .foregroundColor(Color.theme.Secondary)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline:.now()+0.2){
                withAnimation(.linear(duration:2.0)){
                    percentage = 1.0
                }
            }
        }
    }
}
struct ChartView_Preview:PreviewProvider{
    static var previews: some View{
        ChartView(coin:dev.coin)
    }
}
extension ChartView{
    private var chartview:some View{
        GeometryReader{ geometry in
            Path{ path in
                for index in data.indices{
                    let xPosition = geometry.size.width/CGFloat(data.count)*CGFloat(index+1)
                    let yAxis = maxY-minY
                    let yPosition = (1-CGFloat((data[index]-minY)/yAxis)) * geometry.size.height
                    if index == 0{
                        path.move(to:CGPoint(x:xPosition, y:yPosition))
                    }
                    path.addLine(to:CGPoint(x:xPosition, y:yPosition))
                }
            }
            .trim(from:0,to:percentage)
            .stroke(lineColor,style:StrokeStyle(lineWidth:2,lineCap:.round,lineJoin:.round))
        }
    }
}
