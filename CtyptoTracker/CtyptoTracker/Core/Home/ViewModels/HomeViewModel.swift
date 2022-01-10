//
//  HomeViewModel.swift
//  CtyptoTracker
//
//  Created by Mustafo on 31/05/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics : [Statistic] = []
    @Published private(set) var isLoading = false
    
    
    @Published private var coinDataService = CoinDataService()
    @Published private var portfolioDataService = PortfolioDataService()
    @Published var marketDataService = GlobalMarketDataService()
    
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText = ""
    
    @Published var sortOption: SortOption = .holdings
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }

    
    var cancellables = Set<AnyCancellable>()
    
    // Manipulate with adding,removing and updating coins in portfolio
    func updatePortfolioCoins(coin: CoinModel,amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    
    func reload() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.generate(type: .success)
    }
    
    private func addSubscribers() {
        
        $searchText.combineLatest(coinDataService.$coins,$sortOption)
            .delay(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(allCoinsMap)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)
        
        $allCoins
            .combineLatest(portfolioDataService.$portfolioEntities)
            .map(mapCoinsToPortfolioCoins)
            .sink { [weak self] coreDataCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoins(coins: coreDataCoins)
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarket)
            .sink { [weak self] stats in
                self?.statistics = stats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
    }
    
    private func mapGlobalMarket(market: MarketDataModel?,coins: [CoinModel]) -> [Statistic] {
        var stats = [Statistic]()
        guard let globalMarketData = market else {
            print("HMVM")
            return stats
        }
        
        let marketCapStat = Statistic(title: "Market Cap", value: globalMarketData.marketCap, percentageChange: globalMarketData.marketCapChangePercentage24HUsd)
        let volumeStat = Statistic(title: "24Th Volume", value: globalMarketData.volume)
        let btcDominanseStat = Statistic(title: "BTC Dominance", value: globalMarketData.btcDominance)
        
        let portfolioValue = coins
            .map { $0.currentHoldingsValue}
            .reduce(0, +)
        
        let previousValue = portfolioCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentageChange = (coin.priceChangePercentage24H ?? 0.0) / 100
            let previousValue = currentValue / (1 + percentageChange)
            
            return previousValue
        }
        .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolioStat = Statistic(title: "Portfolio", value: portfolioValue.asCurrencyWith2Decimal(), percentageChange: percentageChange)

        
        
        
        stats.append(contentsOf: [marketCapStat,volumeStat,btcDominanseStat,portfolioStat])
        return stats
    }
    
    private func sortPortfolioCoins(coins: [CoinModel]) -> [CoinModel]{
        switch sortOption {
        case .holdings:
            return coins.sorted(by:  {$0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by:  {$0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    private func allCoinsMap(text: String,coins: [CoinModel],sortOption: SortOption)-> [CoinModel] {
        var filteredCoins = filterCoinByText(text: text, coins: coins)
        sortCoins(by: sortOption, coins: &filteredCoins)
        return filteredCoins
    }
    
    private func filterCoinByText(text: String,coins: [CoinModel])-> [CoinModel]{
        guard !text.isEmpty else  {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin in
            coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    private func sortCoins(by sortStyle: SortOption,coins: inout [CoinModel]) {
        switch sortStyle {
        case .rank,.holdings:
            coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed,.holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed :
            coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    private func mapCoinsToPortfolioCoins(coins: [CoinModel],portfolioEntities: [PortfolioEntity])-> [CoinModel] {
        coins.compactMap { coin -> CoinModel? in
            guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id}) else { return nil }
            
            return coin.updateHoldings(amount: entity.amount)
        }
    }
}


