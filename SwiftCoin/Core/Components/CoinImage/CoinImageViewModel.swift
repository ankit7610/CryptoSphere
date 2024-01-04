//
//  CoinImageViewModel.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 22/12/23.
//

import Foundation
import SwiftUI
import Combine
class CoinImageViewModel:ObservableObject{
    @Published var image:UIImage? = nil
    @Published var isLoading:Bool = false
    private let coin:CoinModel
    private let dataService:CoinImageService
    private var cancellables = Set<AnyCancellable>()
    init(coin:CoinModel){
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscibers()
        
    }
    private func addSubscibers(){
        dataService.$image
            .sink{[weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
