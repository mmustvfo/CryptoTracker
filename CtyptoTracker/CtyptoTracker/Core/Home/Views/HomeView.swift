//
//  HomeView.swift
//  CtyptoTracker
//
//  Created by Mustafo on 30/05/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var showPortfolio = false
    @State private var showPortfolioEditor = false
    
    @State var choosenCoin: CoinModel?
    @State var showDetailView = false
    
    var body: some View {
        ZStack {
            Color.colorTheme.background.ignoresSafeArea()
                
            VStack {
                homeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                    .environmentObject(homeViewModel)
                    .sheet(isPresented: $showPortfolioEditor) {
                        PortfolioEditor()
                            .environmentObject(homeViewModel)
                    }
                
                SearchBarView(searchText: $homeViewModel.searchText)
                columnTitles
            
                if !showPortfolio {
                    allCoinsView
                    .transition(.move(edge: .trailing))
                } else {
                    portfolioCoinsView
                    .transition(.move(edge: .leading))
                }
                Spacer(minLength: 0)
            }

        }
        .background(
        NavigationLink(
            destination: LoadingDetailView(coin: $choosenCoin),
            isActive: $showDetailView,
            label: {
                EmptyView()
            })
        )
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
                .colorScheme(.dark)
        }
        .environmentObject(dev.hVM)
    }
}
extension HomeView {
    private var homeHeader: some View {
        HStack() {
            CircleButtonView(imageName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioEditor.toggle()
                    }
                }
                .background(AnimatedBackgroundRing(animate: $showPortfolio))
            Spacer()
            Text(showPortfolio ? "My Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.colorTheme.accentColor)
                .animation(.none)
            Spacer()
            CircleButtonView(imageName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsView: some View {
        List {
            ForEach(homeViewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldings: false)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 10))
                    .onTapGesture {
                        segaue(coin: coin)
                    }
            }
            
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsView: some View {
        List {
            ForEach(homeViewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldings: true)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 10))
                    .onTapGesture {
                        segaue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((homeViewModel.sortOption == .rank || homeViewModel.sortOption == .rankReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: homeViewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    homeViewModel.sortOption = homeViewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Portfolio")
                    Image(systemName: "chevron.down")
                        .opacity((homeViewModel.sortOption == .holdings || homeViewModel.sortOption == .holdingsReversed) ? 1 : 0)
                        .rotationEffect(Angle(degrees: homeViewModel.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        homeViewModel.sortOption = homeViewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((homeViewModel.sortOption == .price || homeViewModel.sortOption == .priceReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: homeViewModel.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    homeViewModel.sortOption = homeViewModel.sortOption == .price ? .priceReversed : .price
                }
            }
            Button(action: {
                withAnimation(.linear(duration: 2)) {
                    homeViewModel.reload()
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: homeViewModel.isLoading ? 360 : 0), anchor: .center)
        }
        .font(.callout)
        .foregroundColor(Color.colorTheme.accentColor)
        .padding(.horizontal)
    }
    
    private func segaue(coin: CoinModel) {
        choosenCoin = coin
        showDetailView = true
    }
}
