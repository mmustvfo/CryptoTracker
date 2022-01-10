//
//  SearchBarView.swift
//  CtyptoTracker
//
//  Created by Mustafo on 04/06/21.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.colorTheme.secondaryTextColor : .colorTheme.accentColor)
            
            TextField("Search by name or symbol", text: $searchText)
                .foregroundColor(Color.colorTheme.accentColor)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10.0)
                        .foregroundColor(Color.colorTheme.accentColor)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 25.0)
            .fill(Color.colorTheme.background)
            .shadow(color: Color.colorTheme.accentColor.opacity(0.15), radius: 10, x: 0.0, y: 0.0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
