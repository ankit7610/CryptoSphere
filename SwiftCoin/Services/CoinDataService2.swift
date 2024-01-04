//
//  CoinDataService2.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 03/01/24.
//
import Foundation
import Combine
class CoinDataService2{
    @Published var allCoins:[CoinModel]=[]
    var coinSubsciption:AnyCancellable?
    init(){
        getCoins()
    }
    func getCoins(){
        guard let url = URL(string:"https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=5&page=1&sparkline=true&price_change_percentage=24h")else{return}
        coinSubsciption = NetworkManager.download(url: url)
            .decode(type:[CoinModel].self, decoder:JSONDecoder())
            .sink(receiveCompletion:NetworkManager.handleCompletion, receiveValue:{
                [weak self] (returnCoins) in
                self?.allCoins=returnCoins
                self?.coinSubsciption?.cancel()
            })
    }
    
}
