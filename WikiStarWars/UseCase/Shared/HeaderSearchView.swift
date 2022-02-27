//
//  HeaderSearchView.swift
//  WikiStarWars
//
//  Created by Albert Cuestas Casas on 5/2/22.
//

import SwiftUI

struct HeaderSearchView: View {
    var delegate: SearchDelegate
    @State private var fieldTextSearch: String = .empty
    @State private var isEditing: Bool = false
    @State private var isFocus: Bool = false

    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass").renderingMode(.template)
                    .resizable().frame(width: 15, height: 15)
                    .foregroundColor(Color("TextColor"))
                    .padding(.leading, 16)
                    .opacity(0.5)

                TextField(delegate.placeHolder, text: $fieldTextSearch)
                    .padding(8).font(Font.system(size: 15))
                    .foregroundColor(Color("TextColor")).accentColor(Color("TextColor"))
                    .onTapGesture {
                        isFocus = true
                        isEditing = true
                    }.onChange(of: fieldTextSearch) { _ in
                        if !fieldTextSearch.isEmpty {
                            delegate.search(query: fieldTextSearch)
                        }
                    }
                    .showClearButton($fieldTextSearch)

            }.background(Color("BackgroundColor")).clipShape(Capsule()).padding(16)

            if isEditing {
                Button(action: {
                    isEditing = false
                    isFocus = false
                    fieldTextSearch = ""
                    hideKeyboard()
                    delegate.search(query: fieldTextSearch)
                }, label: { Text("Cancel") }).frame(height: 21)
                    .padding(.trailing, 15)
                    .foregroundColor(.blue)
            }
        }
        .background(Color.backgroundColor)
        .onChange(of: fieldTextSearch) { _ in
            isEditing = !fieldTextSearch.isEmpty || isFocus
        }
    }
}
