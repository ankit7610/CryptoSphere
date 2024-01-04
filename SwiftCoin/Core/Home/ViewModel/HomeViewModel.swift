//
//  HomeViewModel.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 21/12/23.
//

import Foundation
import Combine
class HomeViewModel: ObservableObject {
    @Published var statistics:[StatisticModel]=[]
    @Published var allCoins:[CoinModel]=[]
    @Published var portfolioCoins: [CoinModel]=[]
    @Published var searchText:String=""
    @Published var isLoading:Bool = false
    @Published var sortOption:SortOption = .holdings
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables=Set<AnyCancellable>()
    enum SortOption{
        case rank,rankreversed,holdings,holdingsReversed,price,priceReversed
    }
    init(){
        addSubcribers()
    }
    func updatePortfolioView(coin:CoinModel,amount:Double){
        portfolioDataService.UpdatePortfolio(coin:coin, amount:amount)
    }
    func addSubcribers(){
        coinDataService.$allCoins
            .sink{ [weak self] (returnedCoins) in
                self?.allCoins=returnedCoins
            }
            .store(in: &cancellables)
        $searchText
            .combineLatest(coinDataService.$allCoins,$sortOption)
            .map(filterAndSortCoins)
            .sink{ [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map{ (coinModels,portfolioEntities) -> [CoinModel] in
                coinModels
                    .compactMap{(coin) -> CoinModel? in
                        guard let entity = portfolioEntities.first(where:{$0.coinID == coin.id}) else{
                            return nil
                        }
                        return coin.updateHoldings(amount:entity.amount)
                    }
            }
            .sink{[weak self] (returnedcoins) in
                guard let self = self else {return}
                self.portfolioCoins = self.SortCoinsIfNeeded(coins: returnedcoins)
            }
            .store(in: &cancellables)
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink{ [weak self] (returnedStats) in
                self?.statistics=returnedStats
                self?.isLoading=false
            }
            .store(in: &cancellables)
        }
    private func filterAndSortCoins(text:String,coins:[CoinModel],sort:SortOption) -> [CoinModel]{
        let filteredcoins = filtercoins(text:text,coins:coins)
        let sortedCoins = sortCoins(sort:sort, coins:filteredcoins)
        return sortedCoins
    }
    private func SortCoinsIfNeeded(coins:[CoinModel]) -> [CoinModel] {
        switch sortOption{
        case .holdings:
            return coins.sorted(by:{$0.currentHoldingsValue>$1.currentHoldingsValue})
        case .holdingsReversed:
            return coins.sorted(by:{$0.currentHoldingsValue<$1.currentHoldingsValue})
        default:
            return coins
        }
    }
    private func filtercoins(text:String,coins:[CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else{
            return coins
        }
        let lowercasedText = text.lowercased()
        return coins.filter{(coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    private func sortCoins(sort:SortOption,coins:[CoinModel]) -> [CoinModel]{
        switch sort {
        case .rank,.holdings:
            return coins.sorted(by:{$0.rank<$1.rank})
        case .rankreversed,.holdingsReversed:
            return coins.sorted(by:{$0.rank>$1.rank})
        case .price:
            return coins.sorted(by:{$0.currentPrice>$1.currentPrice})
        case .priceReversed:
            return coins.sorted(by:{$0.currentPrice<$1.currentPrice})
        }
    }
    private func mapGlobalMarketData(marketDataModel:MarketDataModel?,portfolioCoins:[CoinModel]) -> [StatisticModel] {
        var stats:[StatisticModel]=[]
        guard let data = marketDataModel else{
            return stats
        }
        let marketCap = StatisticModel(title:"Market Cap", value:data.marketCap, percentageChange:data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title:"24h Volume", value:data.volume)
        let btcDominance = StatisticModel(title:"BTC Dominance", value:data.btcDominance)
        let portfolioValue = portfolioCoins
            .map({$0.currentHoldingsValue})
            .reduce(0,+)
        let previousValue = portfolioCoins
            .map{ (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChnage = coin.priceChangePercentage24H!/100
                let previousValue = currentValue/(1+percentChnage)
                return previousValue
            }
            .reduce(0,+)
        let PercentageChange = ((portfolioValue - previousValue)/previousValue)*100
        let portfolio = StatisticModel(title:"Portfolio Value", value:portfolioValue.asCurrencyWith2Decimals(), percentageChange:PercentageChange)
        stats.append(contentsOf:[marketCap,volume,btcDominance,portfolio])
        return stats
    }
    func reload(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type:.success)
    }
}
