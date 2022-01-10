//
//  PortfolioCoinView.swift
//  CtyptoTracker
//
//  Created by Mustafo on 09/06/21.
//

import SwiftUI

struct PortfolioCoinView: View {
    var coin: CoinModel
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.colorTheme.accentColor)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .foregroundColor(Color.colorTheme.secondaryTextColor)
                .font(.caption)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

struct PortfolioCoinView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioCoinView(coin: dev.coin)
    }
}
