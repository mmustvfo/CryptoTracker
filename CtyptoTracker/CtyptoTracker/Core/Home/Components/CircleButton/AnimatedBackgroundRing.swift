//
//  AnimatedBackgroundRing.swift
//  CtyptoTracker
//
//  Created by Mustafo on 30/05/21.
//

import SwiftUI

struct AnimatedBackgroundRing: View {
  
    @Binding var animate: Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 2)
            .foregroundColor(Color.colorTheme.accentColor)
            .scaleEffect(animate ? 1.0 : 0)
            .opacity(animate ? 0 : 1)
            .animation(animate ? Animation.linear(duration: 1): .none)
            
            
            
    }
}

struct AnimatedBackgroundRing_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedBackgroundRing(animate: .constant(true))
    }
}
