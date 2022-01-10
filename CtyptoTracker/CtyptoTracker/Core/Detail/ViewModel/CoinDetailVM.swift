//
//  CoinDetailVM.swift
//  CtyptoTracker
//
//  Created by Mustafo on 13/06/21.
//

import Foundation
import Combine

class CoinDetailVM: ObservableObject {
    
    
    @Published var overviewStatistics: [Statistic] = []
    @Published var additionlStatistics: [Statistic] = []
    @Published var coinDetailModel: CoinDetailDataModel?
    @Published var description: String?
    @Published var websiteURL: URL?
    @Published var redditURL: URL? 

    
    @Published var coin: CoinModel
    
    private let coinDetailService: CoinDetailDataService
    var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailService.$coinDetail
            .combineLatest($coin)
            .map(mapToStatistic)
            .sink { [weak self] stats in
                self?.overviewStatistics = stats.overview
                self?.additionlStatistics = stats.additional
            }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetail
            .sink { [weak self] returnedCoinDetail in
                self?.description = returnedCoinDetail?.readableDescription
                self?.websiteURL = URL(string: returnedCoinDetail?.links?.homepage?.first ?? "")
                self?.redditURL = URL(string: returnedCoinDetail?.links?.subredditURL ?? "")
            }
            .store(in: &cancellables)
        
    }
    
    private func mapToStatistic(detailModel: CoinDetailDataModel?,coinModel: CoinModel) -> (overview: [Statistic],additional: [Statistic]) {

        let overviewArray = mapToOverviewStats(coinModel: coinModel)
        let additionalStatsArray = mapToAdditionalStats(detailModel: detailModel, coinModel: coinModel)

        return (overviewArray,additionalStatsArray)
    }
    
    private func mapToOverviewStats(coinModel: CoinModel) -> [Statistic] {
        let price = coinModel.currentPrice.asCurrencyWith6Decimal()
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceStat = Statistic(title: "Current Price", value: price, percentageChange: pricePercentageChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "00.00")
        let marketCapPercentageChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = Statistic(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentageChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = Statistic(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistic(title: "Volume", value: volume)
        
        let overviewArray: [Statistic] = [
        priceStat, marketCapStat, rankStat, volumeStat
        ]
        
        return overviewArray
    }
    
    private func mapToAdditionalStats(detailModel: CoinDetailDataModel?,coinModel: CoinModel) -> [Statistic] {
        let high = coinModel.high24H?.asCurrencyWith6Decimal() ?? "n/a"
        let highStat = Statistic(title: "24H High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimal() ?? "n/a"
        let lowStat = Statistic(title: "24H Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimal() ?? "n/a"
        let pricePercentageChange2 = coinModel.priceChangePercentage24H
        let pricePercentageChangeStat = Statistic(title: "24H Price Change", value: priceChange, percentageChange: pricePercentageChange2)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.asCurrencyWith6Decimal() ?? "")
        let marketCapPercentageChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: "Market Capital Change", value: marketCapChange, percentageChange: marketCapPercentageChange2)
        
        let blockTime = detailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = Statistic(title: "Block Time", value: blockTimeString)
        
        let hashing = detailModel?.hashingAlgorithm ?? "n/a"
        let hashStat = Statistic(title: "Hashing Algoritm", value: hashing)
        
        let additionalStatsArray: [Statistic] = [highStat, lowStat, pricePercentageChangeStat, marketCapChangeStat, blockStat, hashStat]
        
        return additionalStatsArray
    }
    
}
