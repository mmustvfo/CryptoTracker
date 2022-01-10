//
//  CircleButtonView.swift
//  CtyptoTracker
//
//  Created by Mustafo on 30/05/21.
//

import SwiftUI

struct CircleButtonView: View {
    var imageName: String = "heart.fill"
    var body: some View {
        Image(systemName: imageName)
            .font(.headline)
            .foregroundColor(Color.colorTheme.accentColor)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.colorTheme.background)
            )
            .shadow(color: Color.colorTheme.accentColor.opacity(0.3), radius: 10, x: 0.0, y: 0.0)
            .padding()
        
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonView()
            .previewLayout(.sizeThatFits)
    }
}
