//
//  MarketDataService.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 25/12/23.
//
import Foundation
import Combine
class MarketDataService{
    @Published var marketData: MarketDataModel? = nil
    var marketSubsciption:AnyCancellable?
    init(){
        getData()
    }
    func getData(){
        guard let url = URL(string:"https://api.coingecko.com/api/v3/global")else{return}
        marketSubsciption = NetworkManager.download(url: url)
            .decode(type:GlobalData.self, decoder:JSONDecoder())
            .sink(receiveCompletion:NetworkManager.handleCompletion, receiveValue:{
                [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketSubsciption?.cancel()
            })
    }
    
}
