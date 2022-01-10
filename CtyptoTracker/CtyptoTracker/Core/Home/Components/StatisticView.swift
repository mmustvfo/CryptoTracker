//
//  StatisticView.swift
//  CtyptoTracker
//
//  Created by Mustafo on 06/06/21.
//

import SwiftUI

struct StatisticView: View {
    var statistic: Statistic
    var body: some View {
        VStack(alignment: .leading) {
            Text(statistic.title)
                .font(.caption)
                .foregroundColor(Color.colorTheme.accentColor)
            Text(statistic.value)
                .font(.headline)
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (statistic.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(statistic.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((statistic.percentageChange ?? 0) >= 0 ? Color.colorTheme.green : .colorTheme.red)
            .opacity(statistic.percentageChange == nil ? 0.0 : 1.0)
            
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(statistic: dev.stat)
                .previewLayout(.sizeThatFits)
            StatisticView(statistic: dev.stat2)
                .previewLayout(.sizeThatFits)
            StatisticView(statistic: dev.stat3)
                .previewLayout(.sizeThatFits)
        }
    }
}
