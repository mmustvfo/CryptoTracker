//
//  ChartView.swift
//  CtyptoTracker
//
//  Created by Mustafo on 15/06/21.
//

import SwiftUI

struct ChartView: View {
    private let data: [Double]
    private let max: Double
    private let min: Double
    private let chartColor: Color
    private let endingDate: Date
    private let statingDate: Date
    
    @State private var chartTrim: CGFloat = 0
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        max = data.max() ?? 0
        min = data.min() ?? 0
        endingDate = Date(coinGeckoDate: coin.lastUpdated ?? "")
        statingDate = endingDate.addingTimeInterval(-7*24*60*60)
        chartColor = ((data.last ?? 0) - (data.first ?? 0)) > 0 ? Color.colorTheme.green : .colorTheme.red
        
    }
    var body: some View {
        VStack {
            chartView
                .frame(height: 300)
                .background(chartBackground)
                .overlay(chartOverlay,alignment: .leading)
            chartDates
            
        }
        .font(.caption)
        .foregroundColor(Color.colorTheme.secondaryTextColor)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 2)) {
                    chartTrim = 1
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
    
}

extension ChartView {
    
    private var chartView: some View {
        GeometryReader  { geometry in
            Path { path in
                for index in data.indices {
                    
                    let xPosition = (geometry.size.width / CGFloat(data.count)) * CGFloat(index + 1)
                    
                    let yAxis = max - min
                    let yPosition = CGFloat(1 - (data[index] - min) / yAxis) * geometry.size.height
                    
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    
                }
                
            }
            .trim(from: 0.0, to: chartTrim)
            .stroke(chartColor, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
            .shadow(color: chartColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: chartColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: chartColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: chartColor.opacity(0.1), radius: 10, x: 0.0, y: 40)
            
            
            
        }
    }
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    private var chartOverlay: some View {
        VStack {
            Text(max.formattedWithAbbreviations())
            Spacer()
            Text(((max + min) / 2).formattedWithAbbreviations())
            Spacer()
            Text(min.formattedWithAbbreviations())
        }
    }
    private var chartDates: some View {
        HStack {
            Text(statingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
