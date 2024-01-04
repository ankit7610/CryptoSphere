//
//  CoinImageService.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 22/12/23.
//

import Foundation
import SwiftUI
import Combine
class CoinImageService{
    @Published var image:UIImage? = nil
    private var ImageSubscription:AnyCancellable?
    private let coin:CoinModel
   // private let FileManager=LocalFileManager.instance
    //private let FolderName = "coin_images"
    init(coin:CoinModel){
        self.coin = coin
        getCoinImage()
    }
    private func getCoinImage(){
        guard let url = URL(string:coin.image)else{return}
        ImageSubscription = NetworkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion:NetworkManager.handleCompletion, receiveValue:{
                [weak self] (returnImage) in
                self?.image=returnImage
                self?.ImageSubscription?.cancel()
            })
    }
}
