//
//  PortfolioEditor.swift
//  CtyptoTracker
//
//  Created by Mustafo on 09/06/21.
//

import SwiftUI

struct PortfolioEditor: View {
    @State private var showCheckMark = false
    @EnvironmentObject var vm: HomeViewModel
    @State private var choosenCoin: CoinModel?
    @State private var coinAmount = ""
    
    @State private var currentHoldings: String = ""
    
    
    var saveButtonDisabled: Bool {
        choosenCoin == nil || coinAmount == ""
    }
    var body: some View {
        NavigationView {
            ScrollView(.vertical,showsIndicators: false) {
                VStack(alignment: .leading) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    if choosenCoin != nil {
                        portfolioInputSection
                    }
                    
                }
            }
            .navigationTitle("Portfolio Editor")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.colorTheme.accentColor)
                            .opacity(showCheckMark ? 1.0 : 0)
                        Button("Save",action: saveButtonPressed)
                            .opacity(saveButtonDisabled ? 0.0 : 1.0)
                        
                    }
                }
            })
            .onChange(of: vm.searchText) { text in
                if text == "" {
                    removeSavedCoins()
                }
            }
            .onDisappear {
                vm.searchText = ""
            }
        }
    }
    
    var value: String {
        if let coin = choosenCoin {
            return (coin.currentPrice * (Double(coinAmount) ?? 0.0)).asCurrencyWith6Decimal()
        }
        return ""
    }
    var currentPrice: String {
        if let coin = choosenCoin {
            return coin.currentPrice.asCurrencyWith6Decimal()
        }
        return ""
    }
    
    private func removeSavedCoins() {
        choosenCoin = nil
    }
    
    private func saveButtonPressed() {
        guard let coin = choosenCoin,
              let amount = Double(coinAmount)
              else { return }
        
        // saving choosen coin
        vm.updatePortfolioCoins(coin: coin, amount: amount)
        
        withAnimation(.easeOut) {
            removeSavedCoins()
            showCheckMark = true 
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showCheckMark = false
        }
    }
}

struct PortfolioEditor_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioEditor()
            .environmentObject(dev.hVM)
    }
}

extension PortfolioEditor {
    
    private var portfolioInputSection: some View {
        VStack(alignment:.leading) {
            HStack {
                Text("Current price of \(choosenCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text("\(currentPrice)")
            }
            .padding(.top)
            
            Divider()
            HStack {
                Text("Current Holdings:")
                TextField("\(currentHoldings)\(choosenCoin?.symbol.uppercased() ?? "")", text: $coinAmount)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
            }
            .padding(.top)
            Divider()
            HStack {
                Text("Value:")
                Spacer()
                Text("\(value)")
            }
            .padding(.top)
        }
        .animation(.none)
        .font(.callout.bold())
        .padding(.horizontal,10)
    }
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    PortfolioCoinView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(choosenCoin?.id == coin.id ? Color.colorTheme.green : .clear, lineWidth: 1.0))
                }
                .padding(.vertical,4)
                .padding(.leading)
            }
        })
    }
    private func updateSelectedCoin(coin: CoinModel) {
        choosenCoin = coin
        
        if let entity = vm.portfolioCoins.first(where: { $0.id == coin.id }) {
            currentHoldings = entity.currentHoldings?.asNumberString() ?? ""
        } else {
            currentHoldings = ""
        }
        
    }
}
