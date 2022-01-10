//
//  CoinImageView.swift
//  CtyptoTracker
//
//  Created by Mustafo on 02/06/21.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm: CoinImageVM
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageVM(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let uiImage = vm.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.colorTheme.accentColor)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
