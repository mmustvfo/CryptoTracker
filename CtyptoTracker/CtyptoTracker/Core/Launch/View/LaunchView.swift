//
//  LaunchView.swift
//  CtyptoTracker
//
//  Created by Mustafo on 18/06/21.
//

import SwiftUI


struct LaunchView: View {
    
    private let text: [String] = "Loading portfolio coins...".map {String($0)}
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var showLoadingText = false
    @State private var animateIndex = 0
    @State private var animatedLoops = 0
    @Binding var show: Bool


    var body: some View {
        ZStack {
            Color.launchScreenColors.background
                .ignoresSafeArea()
            
            Image("logo")
                .resizable()
                .frame(width:100,height:100)
            
            ZStack {
                if showLoadingText {
                    HStack(spacing:0) {
                        ForEach(text.indices) { index in
                            Text(text[index])
                                .font(.callout)
                                .foregroundColor(Color.launchScreenColors.accent)
                                .offset(y: animateIndex == index ? -5 : 0)
                                .animation(.easeIn)
                            
                        }
                    }
                    .transition(.scale.animation(.easeIn))
                }
            }
            .offset(y: 50)
        }
        .onAppear {
            withAnimation(.easeIn) {
                showLoadingText.toggle()
            }
        }
        .onReceive(timer, perform: { _ in
            if animateIndex >= text.count - 1 {
                animateIndex = 0
                animatedLoops += 1
                if animatedLoops >= 2 {
                    show = false
                }
            } else {
                animateIndex += 1
            }
        })
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(show: .constant(true))
    }
}


