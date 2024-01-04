//
//  CoinDetailViewModel.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 31/12/23.
//

import Foundation
import Combine
class DetailViewModel:ObservableObject{
    @Published var overviewStatistics:[StatisticModel]=[]
    @Published var addtionalStatistics:[StatisticModel]=[]
    @Published var coin:CoinModel
    @Published var coinDescription:String?=nil
    @Published var websiteURL:String?=nil
    @Published var redditURL:String?=nil
    private let coinDataService:CoinDetailDataService
    private var cancellables=Set<AnyCancellable>()
    init(coin:CoinModel){
        self.coin=coin
        self.coinDataService=CoinDetailDataService(coin:coin)
        self.addSubscibers()
    }
    private func addSubscibers(){
        coinDataService.$coinDetails
            .combineLatest($coin)
            .map( { (coinDetailModel,coinModel) -> (overview:[StatisticModel],additional:[StatisticModel]) in
                let price = coinModel.currentPrice.asCurrencyWith6Decimals()
                let pricePercentChange = coinModel.priceChangePercentage24H
                let priceStat = StatisticModel(title:"Current Price",value:price,percentageChange:pricePercentChange)
                let marketCap = "₹"+(coinModel.marketCap?.formattedWithAbbreviations() ?? "")
                let marketCapPercentChange = coinModel.marketCapChangePercentage24H
                let marketCapStat = StatisticModel(title:"Market Capitalization", value:marketCap,percentageChange:marketCapPercentChange)
                let rank = "\(coinModel.rank)"
                let rankStat = StatisticModel(title:"Rank", value:rank)
                let Volume = "₹"+(coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
                let VolumeStat = StatisticModel(title:"Volume", value:Volume)
                let OverviewArray:[StatisticModel]=[
                    priceStat,marketCapStat,rankStat,VolumeStat
                ]
                let high = "₹"+(coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a")
                let highStat = StatisticModel(title:"24h High", value:high)
                let low = "₹"+(coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a")
                let lowStat = StatisticModel(title:"24h low", value:low)
                let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
                let pricePercentChange2 = coinModel.priceChangePercentage24H
                let priceChangeStat = StatisticModel(title:"24h Price Change", value:priceChange, percentageChange:pricePercentChange2)
                let marketCapChange = "₹"+(coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
                let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
                let marketCapChangeStat = StatisticModel(title:"24h Market Cap Change",value:marketCapChange, percentageChange:marketCapPercentChange2)
                let blocktime = coinDetailModel?.blockTimeInMinutes ?? 0
                let blockTimeString = blocktime == 0 ? "n/a":"\(blocktime)"
                let blockStat = StatisticModel(title:"Block Time", value:blockTimeString)
                let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
                let hashingStat = StatisticModel(title:"Hashing Algorithm", value:hashing)
                let additionalArray:[StatisticModel]=[
                    highStat,lowStat,priceChangeStat,marketCapChangeStat,blockStat,hashingStat
                ]
                return(OverviewArray,additionalArray)
            } )
        .sink{ [weak self] (returnedArrays) in
            self?.overviewStatistics = returnedArrays.overview
            self?.addtionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
        coinDataService.$coinDetails
            .sink{[weak self] (returnedCoins) in
                self?.coinDescription = returnedCoins?.readableDescription
                self?.websiteURL = returnedCoins?.links?.homepage?.first
                self?.redditURL = returnedCoins?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
}
