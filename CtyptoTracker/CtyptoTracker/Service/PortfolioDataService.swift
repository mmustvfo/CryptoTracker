//
//  PortfolioDataService.swift
//  CtyptoTracker
//
//  Created by Mustafo on 10/06/21.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    let container: NSPersistentContainer
    let containerName: String
    let entityName = "PortfolioEntity"
    
    @Published var portfolioEntities: [PortfolioEntity] = []
    
    init() {
        self.containerName = "PortfolioContainer"
        self.container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error occured while creating Core Data storr.Error: \(error.localizedDescription)")
            }
        }
        fetchCoreData()
    }
    
    //MARK: -PUBLIC SECTION
    
    func updatePortfolio(coin: CoinModel,amount: Double) {
        if let entity = portfolioEntities.first(where: { coin.id == $0.coinID}) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else  {
            add(coin: coin, amount: amount)
        }
        applyChanges()
    }
    
    //MARK: -PRIVATE SECTION
    
    private func update(entity: PortfolioEntity,amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func fetchCoreData()  {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            let entities = try container.viewContext.fetch(request)
            self.portfolioEntities = entities
        } catch let error{
            print("Error occured while fetching data from Core Data.Error: \(error.localizedDescription)")
        }
        
    }
    
    
    private func add(coin: CoinModel,amount: Double) {
        let portfolioEntity = PortfolioEntity(context: container.viewContext)
        portfolioEntity.coinID = coin.id
        portfolioEntity.amount = amount
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error occured while saving entities.Error \(error.localizedDescription)")
        }
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
    }
    
    private func applyChanges() {
        save()
        fetchCoreData()
    }
    
    
    
    
}
