//
//  CoinDetailDataService.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 31/12/23.
//
import Foundation
import Combine
class CoinDetailDataService{
    @Published var coinDetails:CoinDetailModel?=nil
    var coinDetailSubsciption:AnyCancellable?
    let coin:CoinModel
    init(coin:CoinModel){
        self.coin=coin
        getCoinsDetails()
    }
    func getCoinsDetails(){
        guard let url = URL(string:"https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")else{return}
        coinDetailSubsciption = NetworkManager.download(url: url)
            .decode(type:CoinDetailModel.self, decoder:JSONDecoder())
            .sink(receiveCompletion:NetworkManager.handleCompletion, receiveValue:{
                [weak self] (returnCoinsDetails) in
                self?.coinDetails=returnCoinsDetails
                self?.coinDetailSubsciption?.cancel()
            })
    }
    
}
