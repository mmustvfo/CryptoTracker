//
//  ContentView.swift
//  CtyptoTracker
//
//  Created by Mustafo on 29/05/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            Color.colorTheme.background
                .ignoresSafeArea()
      
            VStack {
                Text("Accent Color")
                    .foregroundColor(Color.colorTheme.accentColor)
                Text("Red Color")
                    .foregroundColor(Color.colorTheme.red)
                
                
                Text("Green Color")
                    .foregroundColor(Color.colorTheme.green)
                Text("Secondary Text")
                    .foregroundColor(Color.colorTheme.secondaryTextColor)
            }
            .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}


