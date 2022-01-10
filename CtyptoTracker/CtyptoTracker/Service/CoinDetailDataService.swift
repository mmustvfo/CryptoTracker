//
//  CoinDetailDataService.swift
//  CtyptoTracker
//
//  Created by Mustafo on 13/06/21.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetail: CoinDetailDataModel?
    
    var coinDetailCancellable: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetailData()
    }

    func getCoinDetailData() {
        
        let url = "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        
        guard let url = URL(string: url) else { return }
        
        coinDetailCancellable = NetworkingManager.downloadFromUrl(url: url)
            .decode(type: CoinDetailDataModel.self, decoder: JSONDecoder())

            .sink(receiveCompletion: NetworkingManager.completionHandler) {
                [weak self] returnedCoinDetail in
                    self?.coinDetail = returnedCoinDetail
                self?.coinDetailCancellable?.cancel()
            }
    }
}

