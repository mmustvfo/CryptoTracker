//
//  CoinRowView.swift
//  CtyptoTracker
//
//  Created by Mustafo on 30/05/21.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    var showHoldings: Bool
    
    var body: some View {
        ZStack {
            
            HStack {
                leftSideView
                Spacer()
                if showHoldings {
                    centerColumn
                }
                
                rightColumn
            }
            .font(.subheadline)
            .background(Color.colorTheme.background)
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldings: true)
                .previewLayout(.sizeThatFits)
            CoinRowView(coin: dev.coin, showHoldings: true)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
      
    }
}

extension CoinRowView {
    private var leftSideView: some View {
        HStack {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.colorTheme.secondaryTextColor)
                .frame(width: 30)
            CoinImageView(coin: coin)
                .frame(width: 30,height: 30)
                
            Text("\(coin.symbol.uppercased())")
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(Color.colorTheme.accentColor)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimal())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.colorTheme.accentColor)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimal())
                .bold()
                .foregroundColor(Color.colorTheme.accentColor)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "00.00")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.colorTheme.green :
                    Color.colorTheme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
    }
}
