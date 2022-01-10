//
//  CoinModel.swift
//  CtyptoTracker
//
//  Created by Mustafo on 30/05/21.
//

import Foundation

/*
 
 URl:
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=2&sparkline=true&price_change_percentage=24h

 
 Data:
 {
     "id": "nominex",
     "symbol": "nmx",
     "name": "Nominex",
     "image": "https://assets.coingecko.com/coins/images/14424/large/NMX_c_200px.png?1616385215",
     "current_price": 4.78,
     "market_cap": 135559675,
     "market_cap_rank": 251,
     "fully_diluted_valuation": 955832779,
     "total_volume": 138142,
     "high_24h": 4.8,
     "low_24h": 4.49,
     "price_change_24h": 0.245939,
     "price_change_percentage_24h": 5.42525,
     "market_cap_change_24h": 6554866,
     "market_cap_change_percentage_24h": 5.0811,
     "circulating_supply": 28364726.1550775,
     "total_supply": 28364726.1550775,
     "max_supply": 200000000,
     "ath": 8.03,
     "ath_change_percentage": -40.51763,
     "ath_date": "2021-04-12T13:00:21.224Z",
     "atl": 1.34,
     "atl_change_percentage": 256.66652,
     "atl_date": "2021-03-17T14:18:53.032Z",
     "roi": null,
     "last_updated": "2021-05-30T09:37:47.145Z",
     "sparkline_in_7d": {
       "price": [
         4.130818283051831,
         4.092150066532659
       ]
     },
     "price_change_percentage_24h_in_currency": 5.425247455035309
   }
 
 */

struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
    
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
