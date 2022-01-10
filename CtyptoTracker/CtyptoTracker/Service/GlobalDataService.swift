//
//  GlobalDataService.swift
//  CtyptoTracker
//
//  Created by Mustafo on 07/06/21.
//

import Foundation
import Combine

class GlobalMarketDataService {
    @Published var marketData: MarketDataModel?
    
    var marketDataCancellable: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    func getMarketData() {
        
        let url = "https://api.coingecko.com/api/v3/global"
        
        guard let url = URL(string: url) else { return }
        
        marketDataCancellable = NetworkingManager.downloadFromUrl(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())

            .sink(receiveCompletion: NetworkingManager.completionHandler) {
                 [weak self] returnedMarketData in
                self?.marketData = returnedMarketData.data
                self?.marketDataCancellable?.cancel()
            }
    }
}
