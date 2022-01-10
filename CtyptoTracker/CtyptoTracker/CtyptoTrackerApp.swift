//
//  CtyptoTrackerApp.swift
//  CtyptoTracker
//
//  Created by Mustafo on 29/05/21.
//

import SwiftUI


@main
struct CtyptoTrackerApp: App {
    @State var showLoadingView = true
    @StateObject var vm: HomeViewModel = HomeViewModel()
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.colorTheme.accentColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.colorTheme.accentColor)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(vm)
                
                ZStack {
                    if showLoadingView {
                        LaunchView(show: $showLoadingView)
                            .transition(.move(edge: .leading))
                            .animation(.easeIn)
                    }
                }
                .zIndex(2)
            }
        }
    }
}

