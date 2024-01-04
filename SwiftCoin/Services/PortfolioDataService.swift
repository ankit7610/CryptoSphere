//
//  PortfolioDataService.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 29/12/23.
//

import Foundation
import CoreData
class PortfolioDataService {
    private let Container:NSPersistentContainer
    private let ContainerName:String = "PortfolioContainer"
    private let entityName:String = "PortfolioEntity"
    @Published var savedEntities:[PortfolioEntity]=[]
    init(){
        Container = NSPersistentContainer(name:ContainerName)
        Container.loadPersistentStores{(_,error) in
            if let error = error {
                print("\(error)")
            }
            self.getPortfolio()
        }
    }
    func UpdatePortfolio(coin:CoinModel,amount:Double){
        if let entity = savedEntities.first(where:{$0.coinID == coin.id}){
            if amount > 0 {
                update(entity:entity,amount:amount)
            }
            else{
                delete(entity:entity)
            }
        }
        else{
            add(coin:coin,amount:amount)
        }
    }
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName:entityName)
        do{
            savedEntities = try Container.viewContext.fetch(request)
            
        } catch let error{
            print("\(error)")
        }
    }
    private func add(coin:CoinModel,amount:Double){
        let entity = PortfolioEntity(context:Container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applychanges()
    }
    private func update(entity:PortfolioEntity,amount:Double){
        entity.amount = amount
        applychanges()
    }
    private func delete(entity:PortfolioEntity){
        Container.viewContext.delete(entity)
        applychanges()
    }
    private func save(){
        do{
            try Container.viewContext.save()
        } catch let error{
            print("\(error)")
        }
    }
    private func applychanges(){
        save()
        getPortfolio()
    }
}
