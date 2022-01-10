//
//  CoinDataService.swift
//  CtyptoTracker
//
//  Created by Mustafo on 31/05/21.
//

import Foundation
import Combine

class CoinDataService {
    @Published var coins: [CoinModel] = []
    
    var coinResponseCancellable: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins(page: Int = 1) {
        
        let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=\(page)&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: url) else { return }
        
        coinResponseCancellable = NetworkingManager.downloadFromUrl(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
     
            .sink(receiveCompletion: NetworkingManager.completionHandler) {
                 [weak self] data in
                    self?.coins = data
                self?.coinResponseCancellable?.cancel()
            }
    }
}
