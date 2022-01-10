//
//  DetailView.swift
//  CtyptoTracker
//
//  Created by Mustafo on 13/06/21.
//

import SwiftUI

struct LoadingDetailView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            } else {
                ProgressView()
            }
        }
    }
    
}

struct DetailView: View {
    @StateObject var vm: CoinDetailVM
    @State private var showFullDescription = false
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinDetailVM(coin: coin))
    }
    var gridColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let gridSpacing: CGFloat = 30
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                overviewText
                Divider()
                
                descriptionSection
                overviewGrid
                additionalText
                Divider()
                additionalGrid
                linksSection
                
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView {
    private var overviewText: some View {
        Text("Overview")
            .font(.title)
            .foregroundColor(Color.colorTheme.accentColor)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    private var overviewGrid: some View {
        LazyVGrid(columns: gridColumns, alignment: .leading, spacing: gridSpacing, pinnedViews: [], content: {
            ForEach(vm.overviewStatistics) { stat in
                StatisticView(statistic: stat)
            }
        })
    }
    private var additionalText: some View {
        Text("Additional Information")
            .font(.title)
            .foregroundColor(Color.colorTheme.accentColor)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    private var additionalGrid: some View {
        LazyVGrid(columns: gridColumns, alignment: .leading, spacing: gridSpacing, pinnedViews: [], content: {
            ForEach(vm.additionlStatistics) { stat in
                StatisticView(statistic: stat)
            }
        })
    }
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    private var descriptionSection: some View {
        ZStack {
            if let description = vm.description {
                VStack(alignment: .leading) {
                    Text(description)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    }, label: {
                        Text(showFullDescription ? "Less": "See more...")
                            .font(.caption)
                            .fontWeight(.bold)
                    })
                    .accentColor(.blue)
                }
            }
        }
    }
    private var linksSection: some View {
        VStack(alignment: .leading,spacing: 10) {
            if let websiteURL = vm.websiteURL {
                Link("Website", destination: websiteURL)
                    
            }
            if let redditURL = vm.redditURL {
                Link("Reddit",destination: redditURL)
            }
            
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
}



